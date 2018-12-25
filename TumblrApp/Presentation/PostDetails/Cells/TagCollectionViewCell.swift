//
//  TagCollectionViewCell.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell, NibLoadableView {
    
    //MARK: @IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: Variables
   
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
}
