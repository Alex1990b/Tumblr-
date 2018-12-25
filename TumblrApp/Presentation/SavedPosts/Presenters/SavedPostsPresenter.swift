//
//  SavedPostsPresenter.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class SavedPostsPresenter {
    
    //MARK: Variables
    
    weak var delegate: (PostsView & AlertDisplayable)?
    var tableViewGenerator: TableViewGenerator<SavedPostsPresenter>?
    private var savedPosts = [Item]()
    
    init() {
        tableViewGenerator = TableViewGenerator<SavedPostsPresenter>(dataSource: savedPosts, responder: self)
    }
    
    //MARK: Public Methods
    
    func loadPosts() {
        if let posts = CoreDataService.shared.fetchData(entity: Post.self)  {
            savedPosts = posts.filter { $0.isFavorite }
            tableViewGenerator?.removeAll()
            tableViewGenerator?.update(dataSource: savedPosts)
            delegate?.update()
        }
    }
}

//MARK: TableViewGenerable

extension SavedPostsPresenter: TableViewGenerable {
    typealias Item = Post
    typealias Cell = PostTableViewCell
    
    func didSelect(item: Post, index: Int) {
        delegate?.showDetails(with: item)
    }
}



