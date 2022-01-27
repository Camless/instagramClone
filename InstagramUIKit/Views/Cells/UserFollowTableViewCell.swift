//
//  UserFollowTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/27/22.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
	func didTapFollowUnfollowButton(model: String)
}

class UserFollowTableViewCell: UITableViewCell {
	static let identifier = "UserFollowTableViewCell"
	
	weak var delegate: UserFollowTableViewCellDelegate?
	
	private let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 17, weight: .semibold)
		return label
	}()
	
	private let userNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 16, weight: .regular)
		return label
	}()
	
	private let followButton: UIButton = {
		let button = UIButton()
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.clipsToBounds = true
		contentView.addSubview(nameLabel)
		contentView.addSubview(userNameLabel)
		contentView.addSubview(profileImageView)
		contentView.addSubview(followButton)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		profileImageView.image = nil
		nameLabel.text = nil
		userNameLabel.text = nil
		followButton.setTitle(nil, for: .normal)
		followButton.layer.borderWidth = 0
		followButton.backgroundColor = nil
	}
	
	public func configure(with model: String) {
		
	}
}