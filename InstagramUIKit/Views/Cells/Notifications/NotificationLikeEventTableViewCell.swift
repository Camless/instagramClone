//
//  NotificationLikeEventTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/31/22.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
	func didTapRelatedPostButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
	static let identifier = "NotificationLikeEventTableViewCell"
	weak var delegate: NotificationLikeEventTableViewCellDelegate?
	
	private let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .label
		return label
	}()
	
	private let postButton: UIButton = {
		let button = UIButton()
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.clipsToBounds = true
		contentView.addSubview(profileImageView)
		contentView.addSubview(label)
		contentView.addSubview(postButton)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		postButton.setTitle(nil, for: .normal)
		label.text = nil
		profileImageView.image = nil
	}
	
	public func configure(with model: String) {
		
	}

}
