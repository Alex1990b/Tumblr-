//
//  PublicationsViewController.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol PostsView: class {
    func update()
    func loadingDidFailed()
    func showDetails(with post: Post)
}

extension PostsView {
    func loadingDidFailed() { }
}

final class PostsViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var postsListTableView: UITableView!
    
    //MARK: Constants
    
    private let presenter = PostsPresenter()
    private let refreshControl = UIRefreshControl()
    
    //MARK: PostsViewController Lify Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        configureTableView()
        presenter.loadPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Posts"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.savePostsIfNeeded()
    }
}

//MARK: PostsView Delegate

extension PostsViewController: PostsView {
    func showDetails(with post: Post) {
        let postDetailViewController: PostDetailViewController = UIStoryboard.getStoryboard(by: .postDetail).instantiateViewController()
        let presenter = PostDetailsPresenter()
        presenter.post = post
        postDetailViewController.presenter = presenter
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
    func update() {
        postsListTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadingDidFailed() {
        refreshControl.endRefreshing()
    }
}

//MARK: Private Methods

private extension PostsViewController {
    func configureTableView() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .white

        postsListTableView.addSubview(refreshControl)
        postsListTableView.register(PostTableViewCell.self)
        postsListTableView.delegate = presenter.tableViewGenerator
        postsListTableView.dataSource = presenter.tableViewGenerator
    }
}

//MARK: Actions

private extension PostsViewController {
    @objc func refreshData() {
        presenter.loadNewPosts()
    }
}

