//
//  IGFeedPostGeneralTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

/// Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {

	static let identifier = "IGFeedPostGeneralTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .systemOrange
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
