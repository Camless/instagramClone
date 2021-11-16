//
//  SettingsViewController.swift
//  InstagramUIKit
//
//  Created by Carlos Morales III on 11/15/21.
//

import UIKit

struct SettingCellModel {
	let title: String
	let handler: (() -> Void)
}

/// View controller to show user settings
final class SettingsViewController: UIViewController {
	
	private let tableView: UITableView = {
		let tableView = UITableView(frame: .zero,
									style: .grouped)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return tableView
	}()
	
	private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
		configureModels()
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
		let section = [
			SettingCellModel(title: "Log Out") { [weak self] in
				self?.didTapLogOut()
			}
		]
		data.append(section)
	}
	
	private func didTapLogOut() {
		let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
		actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
			DispatchQueue.main.async {
				AuthManager.shared.logOut { success in
					if success {
						// present log in
						let loginVC = LoginViewController()
						loginVC.modalPresentationStyle = .fullScreen
						self.present(loginVC, animated: true) {
							self.navigationController?.popToRootViewController(animated: false)
							self.tabBarController?.selectedIndex = 0
						}
					} else {
						// error logging out
						fatalError("Could not log out user")
					}
				}
			}
		}))
		actionSheet.popoverPresentationController?.sourceView = tableView
		actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
		
		present(actionSheet, animated: true)
	}
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = data[indexPath.section][indexPath.row].title
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		data[indexPath.section][indexPath.row].handler()
	}
}
