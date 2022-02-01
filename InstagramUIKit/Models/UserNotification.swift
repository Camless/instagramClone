//
//  UserNotification.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 2/1/22.
//

import Foundation

struct UserNotification {
	let type: UserNotificationType
	let text: String
	let user: User
}

enum UserNotificationType {
	case like(post: UserPost)
	case follow(state: FollowState)
}
