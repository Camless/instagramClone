//
//  UserPostModel.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/26/22.
//

import Foundation

public struct UserPost {
	let identifier: String
	let postType: UserPostType
	let thumbnailImage: URL
	let postURL: URL // either video or full resolution photo
	let caption: String?
	let likeCount: [PostLike]
	let comments: [PostComment]
	let createdDate: Date
	let taggedUsers: [User]
	let owner: User
}

public enum UserPostType: String {
	case photo = "Photo"
	case video = "Video"
}
