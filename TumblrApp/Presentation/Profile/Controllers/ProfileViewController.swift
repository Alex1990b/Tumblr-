//
//  ProfileViewController.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol ProfileView: class {
    func update(with user: User)
}

final class ProfileViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    
    //MARK: Constants
    
    private let presenter = ProfilePresenter()
    
    //MARK: ProfileViewController Lify Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.fetchUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Profile"
    }
}

//MARK: ProfileView Delegate

extension ProfileViewController: ProfileView {
    func update(with user: User) {
        userNameLabel.text = user.name
        followingCountLabel.text = String(user.following)
        likesCountLabel.text = String(user.likes)
    }
}

//MARK: @IBActions

private extension ProfileViewController {
    @IBAction func showPostsButtonTapped(_ sender: UIButton) {
        let postViewController: SavedPostsViewController = UIStoryboard.getStoryboard(by: .savedPost).instantiateViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
