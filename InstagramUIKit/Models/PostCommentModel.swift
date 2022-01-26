//
//  PostCommentModel.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/26/22.
//

import Foundation

struct PostComment {
	let identifier: String
	let username: String
	let text: String
	let createdDate: Date
	let likes: [CommentLike]
}
