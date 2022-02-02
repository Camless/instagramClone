//
//  IGFeedPostTableViewCell.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/22/21.
//

import AVFoundation
import UIKit
import SDWebImage

/// Cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
	
	static let identifier = "IGFeedPostTableViewCell"
	private let postImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = nil
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private var player: AVPlayer?
	private var playerLayer = AVPlayerLayer()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.layer.addSublayer(playerLayer)
		contentView.addSubview(postImageView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		postImageView.frame = contentView.bounds
		playerLayer.frame = contentView.bounds
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		postImageView.image = nil
	}
	
	public func configure(with post: UserPost) {
		// configure cell
		postImageView.image = UIImage(named: "photoTest")
		
		return
		switch post.postType {
		case .video:
			// Play video
			player = AVPlayer(url: post.postURL)
			playerLayer.player = player
			playerLayer.player?.volume = 0
			playerLayer.player?.play()
		case .photo:
			// Show image
			postImageView.sd_setImage(with: post.postURL, completed: nil)
			break
		}
	}

}
