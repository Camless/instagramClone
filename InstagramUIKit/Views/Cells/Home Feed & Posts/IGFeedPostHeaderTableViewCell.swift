//
//  IGFeedPostHeaderCollectionViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit
import SDWebImage

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
	static let identifier = "IGFeedPostHeaderTableViewCell"
	weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
	
	private let profilePhotoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		
		return imageView
	}()
	
	private let usernameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 18, weight: .medium)
		return label
	}()
	
	private let moreButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
		return button
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(profilePhotoImageView)
		contentView.addSubview(usernameLabel)
		contentView.addSubview(moreButton)
		
		moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let size = contentView.height - 4
		profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
		profilePhotoImageView.layer.cornerRadius = size / 2
		
		moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
		usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10, y: 2, width: contentView.width - (size * 2) - 15, height: size)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		usernameLabel.text = nil
		profilePhotoImageView.image = nil
	}
	
	public func configure(with model: User) {
		// configure cell
		usernameLabel.text = model.username
		profilePhotoImageView.image = UIImage(systemName: "person.circle")
//		profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
	}
	
	@objc private func didTapButton() {
		delegate?.didTapMoreButton()
	}
}

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
	func didTapMoreButton()
}
