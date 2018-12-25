//
//  PostDetailViewController.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol PostDetailsView: class {
    func update(with post: Post)
}

final class PostDetailViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var blogTitleLabel: UILabel!
    @IBOutlet private weak var tagsCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var tagsCollectionView: UICollectionView!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var notesCountLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var tagCollectionViewModel: TagCollectionViewModel!
    
    //MARK: Variables
    
    var presenter: PostDetailsPresenter?
    
    //MARK: PostDetailViewController Lify Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isSelected = presenter?.post.isFavorite ?? false
        configureCollectionView()
        presenter?.delegate = self
        presenter?.fetchPost()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Post Detail"
        tagsCollectionView.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let newHeight = tagsCollectionView.collectionViewLayout.collectionViewContentSize.height
        tagsCollectionViewHeightConstraint.constant = newHeight
    }
}

//MARK: PostDetailsView Delegate

extension PostDetailViewController: PostDetailsView {
    func update(with post: Post) {
        if let imageUrl = post.linkImage {
            postImageView.loadImage(urlString: imageUrl)
        } else {
            postImageView.image = #imageLiteral(resourceName: "noImageIcon")
        }
        blogTitleLabel.text = post.blog?.title
        publisherLabel.text = post.publisher
        descriptionLabel.text = post.title
        notesCountLabel.text = "notes: \(post.noteCount)"
        if let tags = post.tags {
            tagCollectionViewModel.tags = tags
        }
        tagsCollectionView.reloadData()
    }
}

//MARK: @IBActions

private extension PostDetailViewController {
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        presenter?.updatePost(isFavorite: sender.isSelected)
    }
}

//MARK: Private Methods

private extension PostDetailViewController {
    func configureCollectionView() {
        tagsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        let leftAlignedCollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        tagsCollectionView.collectionViewLayout = leftAlignedCollectionViewFlowLayout
        tagsCollectionView.register(TagCollectionViewCell.self)
    }
}


