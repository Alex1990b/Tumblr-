//
//  PostDetailsPresenter.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class PostDetailsPresenter {
    
    //MARK: Variables
    
    weak var delegate: PostDetailsView?
    var post: Post!
    
    //MARK: Public Methods
   
    func fetchPost() {
        delegate?.update(with: post)
    }
    
    func updatePost(isFavorite: Bool) {
        post.isFavorite = isFavorite
        CoreDataService.shared.saveContext()
    }
}
