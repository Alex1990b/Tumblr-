//
//  BannerTableViewCell.swift
//  Vixinity
//
//  Created by Sasha on 31.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell, ConfigurableCell {
    typealias T = Post
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var createdDateLabel: UILabel!
    
    //MARK: Configure
    
    func configure(_ item: Post, at indexPath: IndexPath) {
        titleLabel.text = item.title
        
        if let date = item.date {
            createdDateLabel.text = date.detectDate?.toString(expectedFormat: .yyyyMMddHHmm)
        } else {
            createdDateLabel.text = nil
        }
        
        if let imageUrl = item.linkImage {
            postImageView.loadImage(urlString: imageUrl, in: self, at: indexPath)
        } else {
            postImageView.image = #imageLiteral(resourceName: "noImageIcon")
        }
    }
    
    //MARK: PostTableViewCell Lify Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
