//
//  PostViewController.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import UIKit

class PostViewController: UIViewController {
	
	/*
	 Section
	 - Header model
	 Section
	 - Post cell model
	 Section
	 - Action buttons cell model
	 Section
	 - n Number of general models for comments
	 */

	private let model: UserPost?
	private var renderModels = [PostRenderViewModel]()
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
		tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
		tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
		tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
		
		return tableView
	}()
	
	init(model: UserPost?) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
		configureModels()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}

	private func configureModels() {
		guard let userPostModel = self.model else {
			return
		}
		// Header
		renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
		
		// Post
		renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
		
		// Actions
		renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
		
		// 4 Comments
		var comments = [PostComment]()
		for x in 0..<4 {
			comments.append(PostComment(identifier: "123_\(x)", username: "@kev", text: "Great post...", createdDate: Date(), likes: []))
		}
		renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
	}
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return renderModels.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch renderModels[section].renderType {
		case .actions(_): return 1
		case .comments(let comments): return comments.count > 4 ? 4 : comments.count
		case .primaryContent(_): return 1
		case .header(_): return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = renderModels[indexPath.section]
		switch model.renderType {
		case .actions(let actions):
			let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier) as! IGFeedPostActionsTableViewCell
			return cell
		case .comments(let comments):
			let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier) as! IGFeedPostGeneralTableViewCell
			return cell
		case .primaryContent(let post):
			let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier) as! IGFeedPostTableViewCell
			return cell
		case .header(let user):
			let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier) as! IGFeedPostHeaderTableViewCell
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let model = renderModels[indexPath.section]
		
		switch model.renderType {
		case .actions(_): return 60
		case .comments(_): return 50
		case .primaryContent(_): return tableView.width
		case .header(_): return 50
		}
	}
}
