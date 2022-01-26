//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
	static let identifier = "ProfileInfoHeaderCollectionReusableView"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .systemBlue
		clipsToBounds = true
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
