//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
	func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
	func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
	func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
	func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
	static let identifier = "ProfileInfoHeaderCollectionReusableView"
	
	public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
	
	private let profilePhotoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .red
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	private let postsButton: UIButton = {
		let button = UIButton()
		button.setTitle("Posts", for: .normal)
		button.backgroundColor = .secondarySystemBackground
		button.setTitleColor(.label, for: .normal)
		return button
	}()
	
	private let followingButton: UIButton = {
		let button = UIButton()
		button.setTitle("Following", for: .normal)
		button.backgroundColor = .secondarySystemBackground
		button.setTitleColor(.label, for: .normal)
		return button
	}()
	
	private let followersButton: UIButton = {
		let button = UIButton()
		button.setTitle("Followers", for: .normal)
		button.backgroundColor = .secondarySystemBackground
		button.setTitleColor(.label, for: .normal)
		return button
	}()
	
	private let editProfileButton: UIButton = {
		let button = UIButton()
		button.setTitle("Edit Your Profile", for: .normal)
		button.setTitleColor(.label, for: .normal)
		return button
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Joe Jubba"
		label.textColor = .label
		label.numberOfLines = 1
		return label
	}()
	
	private let bioLabel: UILabel = {
		let label = UILabel()
		label.text = "This is the first account!"
		label.textColor = .label
		label.numberOfLines = 0 // line wrap?
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		addButtonActions()
		backgroundColor = .systemBackground
		clipsToBounds = true
	}
	
	private func addSubviews() {
		addSubview(profilePhotoImageView)
		addSubview(followersButton)
		addSubview(followingButton)
		addSubview(postsButton)
		addSubview(bioLabel)
		addSubview(nameLabel)
		addSubview(editProfileButton)
	}
	
	private func addButtonActions() {
		followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
		followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
		postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
		editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let profilePhotoSize = width / 4
		let buttonHeight = profilePhotoSize / 2
		let countButtonWidth = (width - 10 - profilePhotoSize) / 3
		let bioLabelSize = sizeThatFits(frame.size)
		
		profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2.0
		
		profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
		
		postsButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
		
		followersButton.frame = CGRect(x: postsButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
		
		followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
		
		editProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight, width: countButtonWidth * 3, height: buttonHeight).integral
		
		nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom, width: width - 10, height: 50).integral
		
		bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width - 10, height: bioLabelSize.height).integral
	}
	
	// MARK: - Actions
	
	@objc private func didTapFollowersButton() {
		delegate?.profileHeaderDidTapFollowersButton(self)
	}
	@objc private func didTapFollowingButton() {
		delegate?.profileHeaderDidTapFollowingButton(self)
	}
	@objc private func didTapEditProfileButton() {
		delegate?.profileHeaderDidTapEditProfileButton(self)
	}
	@objc private func didTapPostsButton() {
		delegate?.profileHeaderDidTapPostsButton(self)
	}
}
