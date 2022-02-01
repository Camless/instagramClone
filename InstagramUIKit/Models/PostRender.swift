//
//  PostRender.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 2/1/22.
//

import Foundation

/// Model of rendered post
struct PostRenderViewModel {
	let renderType: PostRenderType
}

enum PostRenderType {
	case header(provider: User)
	case primaryContent(provider: UserPost) // post
	case actions(provider: String) // like, comment, share
	case comments(comments: [PostComment])
}
