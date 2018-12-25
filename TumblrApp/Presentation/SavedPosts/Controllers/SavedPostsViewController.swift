//
//  SavedPostsViewController.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class SavedPostsViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var savedPostTableView: UITableView!
    
    //MARK: Constants
    
    private let presenter = SavedPostsPresenter()
    
    //MARK: SavedPostsViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Saved Posts"
    }
}

//MARK: PostsView

extension SavedPostsViewController: PostsView {
    func showDetails(with post: Post) {
        let postDetailViewController: PostDetailViewController = UIStoryboard.getStoryboard(by: .postDetail).instantiateViewController()
        let presenter = PostDetailsPresenter()
        presenter.post = post
        postDetailViewController.presenter = presenter
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
    func update() {
        savedPostTableView.reloadData()
    }
}

//MARK: Private Methods

private extension SavedPostsViewController {
    func configureTableView() {
        savedPostTableView.register(PostTableViewCell.self)
        savedPostTableView.delegate = presenter.tableViewGenerator
        savedPostTableView.dataSource = presenter.tableViewGenerator
    }
}
