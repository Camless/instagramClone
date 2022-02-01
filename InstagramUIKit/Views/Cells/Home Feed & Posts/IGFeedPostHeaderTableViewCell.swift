//
//  IGFeedPostHeaderCollectionViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
	static let identifier = "IGFeedPostHeaderTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .systemBlue
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
