//
//  IGFeedPostActionsTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
	func didTapLikeButton()
	func didTapCommentButton()
	func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

	static let identifier = "IGFeedPostActionsTableViewCell"
	weak var delegate: IGFeedPostActionsTableViewCellDelegate?
	
	private let likeButton: UIButton = {
		let button = UIButton()
		let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
		let image = UIImage(systemName: "heart", withConfiguration: configuration)
		button.setImage(image, for: .normal)
		button.tintColor = .label
		return button
	}()
	
	private let commentButton: UIButton = {
		let button = UIButton()
		let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
		let image = UIImage(systemName: "message", withConfiguration: configuration)
		button.setImage(image, for: .normal)
		button.tintColor = .label
		return button
	}()
	
	private let sendButton: UIButton = {
		let button = UIButton()
		let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
		let image = UIImage(systemName: "paperplane", withConfiguration: configuration)
		button.setImage(image, for: .normal)
		button.tintColor = .label
		return button
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(sendButton)
		contentView.addSubview(commentButton)
		contentView.addSubview(likeButton)
		
		sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
		likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
		commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// like, comment, send
		let buttonSize = contentView.height - 10
		
		let buttons = [likeButton, commentButton, sendButton]
		for x in 0..<buttons.count {
			let button = buttons[x]
			button.frame = CGRect(x: (CGFloat(x) * buttonSize) + (10 * CGFloat(x + 1)), y: 5, width: buttonSize, height: buttonSize)
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	public func configure(with model: UserPost) {
		// configure cell
	}
	
	@objc private func didTapLikeButton() {
		delegate?.didTapLikeButton()
	}
	
	@objc private func didTapCommentButton() {
		delegate?.didTapCommentButton()
	}
	
	@objc private func didTapSendButton() {
		delegate?.didTapSendButton()
	}
}
