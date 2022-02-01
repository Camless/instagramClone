//
//  NotificationsViewController.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import UIKit

class NotificationsViewController: UIViewController {
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.isHidden = false
		tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
		tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
		return tableView
	}()
	
	private lazy var noNotificationsView = noNotificationView()
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.tintColor = .label
		return spinner
	}()
	
	private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
		fetchNotifications()
		navigationItem.title = "Notifications"
		view.backgroundColor = .systemBackground
		
		view.addSubview(tableView)
//		view.addSubview(spinner)
		
//		spinner.startAnimating()
		
		tableView.delegate = self
		tableView.dataSource = self
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
//		spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//		spinner.center = view.center
	}
	
	private func addNoNotificationsView() {
		tableView.isHidden = true
		view.addSubview(noNotificationsView)
		noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 4)
		noNotificationsView.center = view.center
	}
	
	private func fetchNotifications() {
		for x in 0...100 {
			let user: User = User(username: "joe", name: (first: "", last: ""), profilePhoto: URL(string: "https://www.google.com")!, birthdate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
			let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
			let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .notFollowing), text: "Hello World", user: user)
			models.append(model)
		}
	}

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.row]
		switch model.type {
		case .like(_):
			// like cell
			let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
			cell.configure(with: model)
			cell.delegate = self
			return cell
		case .follow:
			// follow cell
			let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
//			cell.configure(with: model)
			cell.delegate = self
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 52
	}
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
	func didTapRelatedPostButton(model: UserNotification) {
		switch model.type {
		case .like(let post):
			let vc = PostViewController(model: post)
			vc.title = post.postType.rawValue
			vc.navigationItem.largeTitleDisplayMode = .never
			navigationController?.pushViewController(vc, animated: true)
		case .follow(_):
			fatalError("Dev Issue: Should never get called")
		}
	}
	
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
	func didTapFollowUnfollowButton(model: UserNotification) {
		print("Tapped button")
	}
}
