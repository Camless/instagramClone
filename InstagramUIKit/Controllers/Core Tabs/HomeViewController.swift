//
//  ViewController.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
	
	private var feedRenderModels = [HomeFeedRenderViewModel]()

	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
		tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
		tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
		tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(tableView)
		createMockModels()
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		handleNotAuthenticated()
	}
	
	private func handleNotAuthenticated() {
		// Check auth status
		if Auth.auth().currentUser == nil {
			let loginVC = LoginViewController()
			loginVC.modalPresentationStyle = .fullScreen
			present(loginVC, animated: false)
		}
	}
	
	private func createMockModels() {
		let user: User = User(username: "@joe", name: (first: "", last: ""), profilePhoto: URL(string: "https://www.google.com")!, birthdate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
		let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
		
		var comments = [PostComment]()
		for x in 0..<2 {
			comments.append(PostComment(identifier: "\(x)", username: "@brady", text: "Where is this going to be..", createdDate: Date(), likes: []))
		}
		
		for x in 0..<5 {
			let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
			feedRenderModels.append(viewModel)
		}
	}


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	// MARK: - Number of Sections
	func numberOfSections(in tableView: UITableView) -> Int {
		print(feedRenderModels.count * 4)
		return feedRenderModels.count * 4 // Since each model has 4 sections
		
	}
	
	// MARK: - Number of Rows in Section
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let x = section
		let model: HomeFeedRenderViewModel
		
		if x == 0 {
			model = feedRenderModels[0]
		} else {
			let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
			model = feedRenderModels[position]
		}
		
		let subSection = x % 4
		if subSection == 0 {
			// header
			return 1
		} else if subSection == 1 {
			// post
			return 1
		} else if subSection == 2 {
			// actions
			return 1
		} else if subSection == 3 {
			// comments
			let commentsModel = model.comments
			switch commentsModel.renderType {
			case .comments(let comments):
				return comments.count > 2 ? 2 : comments.count
			default:
				fatalError("Invalid case")
			}
		}
		
		return 0 // Error occurs here
	}
	
	// MARK: - Cell Configuration
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let x = indexPath.section
		let model: HomeFeedRenderViewModel
		
		if x == 0 {
			model = feedRenderModels[0]
		} else {
			let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
			model = feedRenderModels[position]
			print(model)
		}
		
		let subSection = x % 4
		if subSection == 0 {
			// header
			switch model.header.renderType {
			case .header(let user):
				let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier) as! IGFeedPostHeaderTableViewCell
				cell.configure(with: user)
				cell.delegate = self
				return cell
			default:
				fatalError()
			}
		} else if subSection == 1 {
			// post
			switch model.post.renderType {
			case .primaryContent(let post):
				let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier) as! IGFeedPostTableViewCell
				cell.configure(with: post)
				return cell
			default:
				fatalError()
			}
		} else if subSection == 2 {
			// actions
			switch model.actions.renderType {
			case .actions(let provider):
				let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier) as! IGFeedPostActionsTableViewCell
				cell.delegate = self
				return cell
			default:
				fatalError()
			}
		} else if subSection == 3 {
			// comments
			switch model.comments.renderType {
			case .comments(let comments):
				let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier) as! IGFeedPostGeneralTableViewCell
				return cell
			default:
				fatalError("Invalid case")
			}
		}
		
		return UITableViewCell() // Should never occur
	}
	
	// MARK: - Row Selection
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: - Row Height
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let subSection = indexPath.section % 4
		
		if subSection == 0 { // Header
			return 70
		} else if subSection == 1 { // Post
			return tableView.width
		} else if subSection == 2 { // Actions
			return 60
		} else if subSection == 3 { // Comment *Row*
			return 50
		} else {
			return 0 // Should never reach this
		}
	}
	
	// MARK: - Footer Section Height
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		let subSection = section % 4
		return subSection == 3 ? 70 : 0
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
	func didTapMoreButton() {
		let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
		actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		actionSheet.addAction(UIAlertAction(title: "Report", style: .destructive, handler: { [weak self] _ in
			self?.reportPost()
		}))
		present(actionSheet, animated: true)
	}
	
	func reportPost() {
		
	}
}

extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
	func didTapLikeButton() {
		print("like")
	}
	
	func didTapCommentButton() {
		print("comment")
	}
	
	func didTapSendButton() {
		print("send")
	}
	
	
}
