//
//  noNotificationView.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/27/22.
//

import UIKit

class noNotificationView: UIView {
	
	private let label: UILabel = {
		let label = UILabel()
		label.text = "No Notifications Yet"
		label.numberOfLines = 1
		label.textColor = .secondaryLabel
		label.textAlignment = .center
		return label
	}()
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = .secondaryLabel
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(systemName: "bell")
		return imageView
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.frame = CGRect(x: (width - 50) / 2, y: 0, width: 50, height: 50).integral
		label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height - 50).integral
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(imageView)
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
