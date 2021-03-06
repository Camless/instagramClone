//
//  DatabaseManager.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
	static let shared = DatabaseManager()
	private let database = Database.database().reference()
	
	//MARK: - Public
	
	/// Check if username and email is available
	///  - Parameters
	///  	- email: String representing email
	///  	- username: String representing username
	public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
		completion(true)
	}
	
	/// Inserts new user data to db
	///  - Parameters
	///  	- email: String representing email
	///  	- username: String representing username
	///  	- completion: Async callback for result if db entry succeded
	public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
		database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
			if error == nil {
				// succeeded
				completion(true)
				return
			} else {
				// failed
				completion(false)
				return
			}
		}
	}
	
	
}
