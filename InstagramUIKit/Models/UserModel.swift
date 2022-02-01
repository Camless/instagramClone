//
//  UserModel.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 1/26/22.
//

import Foundation

struct User {
	let username: String
	let name: (first: String, last: String)
	let profilePhoto: URL
	let birthdate: Date
	let gender: Gender
	let counts: UserCount
	let joinDate: Date
}

enum Gender {
	case male, female, other
}
