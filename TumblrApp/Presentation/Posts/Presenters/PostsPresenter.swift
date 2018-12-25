//
//  DashboardPresenter.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class PostsPresenter {
    
    //MARK: Constants
    
    private let networkService = PostNetworkService()
    
    //MARK: Variables
    
    weak var delegate: (PostsView & AlertDisplayable)?
    var tableViewGenerator: TableViewGenerator<PostsPresenter>?
    private var postParameters: FetchPostsParameters!
    private var isLoading = false
    
    init() {
        tableViewGenerator = TableViewGenerator<PostsPresenter>(dataSource: [Post](), responder: self)
        postParameters = FetchPostsParameters(offset: 0, pageNumber: 1)
    }
    
    //MARK: Public Methods
    
    func loadPosts(havePostsAlredyLoaded: Bool = false) {
        
        if  Connectivity.isConnectedToInternet() {
            
            fetchPosts(parameters: postParameters) { [weak self]  postResponse, posts in
                
                guard let strongSelf = self else { return }
                
                if !posts.isEmpty {
                    strongSelf.updatePostParameters(with: postResponse)
                    strongSelf.tableViewGenerator?.update(dataSource: posts)
                    strongSelf.delegate?.update()
                    strongSelf.isLoading = false
                }
            }
        } else {
            if let posts = CoreDataService.shared.fetchData(entity: Post.self,
                                                            sortDescriptorKey: "date") {
                if !havePostsAlredyLoaded {
                    tableViewGenerator?.update(dataSource: posts)
                    delegate?.update()
                    isLoading = false
                }
            }
        }
    }
    
    func loadNewPosts() {
        
        if  Connectivity.isConnectedToInternet() {
            
            postParameters = FetchPostsParameters(offset: 0, pageNumber: 1)
            fetchPosts(parameters: postParameters) { [weak self]  postResponse, posts in
                
                guard let strongSelf = self else { return }
                strongSelf.tableViewGenerator?.removeAll()
                strongSelf.tableViewGenerator?.update(dataSource: posts)
                strongSelf.delegate?.update()
                strongSelf.updatePostParameters(with: postResponse)
                
                strongSelf.isLoading = false
            }
        } else {
            delegate?.loadingDidFailed()
            isLoading = false
        }
    }
    
    func savePostsIfNeeded() {
        CoreDataService.shared.saveContext()
    }
}

//MARK: TableViewGenerable

extension PostsPresenter: TableViewGenerable {
    typealias Item = Post
    typealias Cell = PostTableViewCell
    
    func loadNewItems() {
        if !isLoading  {
            isLoading = true
            loadPosts(havePostsAlredyLoaded: true)
        }
    }
    
    func didSelect(item: Post, index: Int) {
        delegate?.showDetails(with: item)
    }
}

//MARK: Private Methods

private extension PostsPresenter {
    func fetchPosts(parameters: FetchPostsParameters, completion: @escaping (PostResponse?, [Post]) -> ()) {
        if  Connectivity.isConnectedToInternet() {
            networkService.fetchPosts(parameters: parameters) { [weak self] (postResponse, error) in
                if let error = error {
                    self?.delegate?.showAlert(with: error)
                }
                if let posts = postResponse?.response.posts {
                    completion(postResponse, posts)
                }
            }
        }
    }
    
    func updatePostParameters(with postResponse: PostResponse?) {
        if let offest = postResponse?.response.links?.next.queryParams.offset,
            let pageNumber = postResponse?.response.links?.next.queryParams.pageNumber,
            let newOffset = Int(offest),
            let newPage = Int(pageNumber) {
            postParameters.offset = newOffset
            postParameters.pageNumber = newPage
        }
    }
}




