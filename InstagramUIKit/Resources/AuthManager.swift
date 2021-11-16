//
//  AuthManager.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import Foundation
import FirebaseAuth

public class AuthManager {
	static let shared = AuthManager()
	
	//MARK: - Public
	
	public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
		/*
		 - Check if username is available
		 - Check if email is available
		 - Create account
		 - Insert acc to db
		 */
		
		DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
			if canCreate {
				Auth.auth().createUser(withEmail: email, password: password) { result, error in
					guard error == nil, result != nil else {
						completion(false)
						return
					}
					
					// Insert into db
					DatabaseManager.shared.insertNewUser(with: email, username: username, completion: { inserted in
						if inserted {
							completion(true)
							return
						} else {
							completion(false)
							return
						}
					})
				}
			} else {
				// user / email already exists
				completion(false)
				return
			}
		}
		
		
	}
	
	public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
		if let email = email {
			Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
				guard authResult != nil, error == nil else {
					completion(false)
					return
				}
				
				completion(true)
			}
		} else if let username = username {
			print(username)
		}
	}
	
	/// Attempt to logout Firebase user
	public func logOut(completion: (Bool) -> Void) {
		do {
			try Auth.auth().signOut()
			completion(true)
			return
		} catch {
			completion(false)
			print(error)
			return
		}
	}
}
