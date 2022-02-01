//
//  IGFeedPostActionsTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

class IGFeedPostActionsTableViewCell: UITableViewCell {

	static let identifier = "IGFeedPostActionsTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .systemGreen
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	public func configure() {
		// configure cell
	}
}
