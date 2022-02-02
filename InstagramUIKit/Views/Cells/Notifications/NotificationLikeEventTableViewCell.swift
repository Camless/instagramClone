//
//  NotificationLikeEventTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/31/22.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
	func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
	static let identifier = "NotificationLikeEventTableViewCell"
	weak var delegate: NotificationLikeEventTableViewCellDelegate?
	private var model: UserNotification?
	
	private let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .tertiarySystemBackground
		return imageView
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .label
		label.text = "@joe liked your photo."
		return label
	}()
	
	private let postButton: UIButton = {
		let button = UIButton()
		button.setBackgroundImage(UIImage(named: "photoTest"), for: .normal)
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.clipsToBounds = true
		contentView.addSubview(profileImageView)
		contentView.addSubview(label)
		contentView.addSubview(postButton)
		postButton.addTarget(self, action: #selector(didTapPostButton) , for: .touchUpInside)
		selectionStyle = .none
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let size = contentView.height - 4
		
		profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
		profileImageView.layer.cornerRadius = profileImageView.height / 2
		
		postButton.frame = CGRect(x: contentView.width - size - 5, y: 2, width: size, height: size)
		
		label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - size - profileImageView.width - 16, height: contentView.height)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		postButton.setTitle(nil, for: .normal)
		label.text = nil
		profileImageView.image = nil
	}
	
	public func configure(with model: UserNotification) {
		self.model = model
		switch model.type {
		case .like(let post):
			let thumbnail = post.thumbnailImage
			guard !thumbnail.absoluteString.contains("google.com") else {
				return
			}
			postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
		case .follow:
			break
		}
		
		label.text = model.text
		profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
	}
	
	@objc private func didTapPostButton() {
		guard let model = model else {
			return
		}
		delegate?.didTapRelatedPostButton(model: model)
	}

}
