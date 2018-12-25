//
//  LeftMenuTableViewCell.swift
//  Vixinity
//
//  Created by Sasha on 18.09.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class LeftMenuTableViewCell: UITableViewCell, ConfigurableCell {
    typealias T = LeftMenuModel
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    //MARK: Public Methods
    
    func configure(_ item: LeftMenuModel, at indexPath: IndexPath) {
        iconImageView.image = UIImage(named: item.iconImageName)
        nameLabel.text = item.name
    }
    
    //MARK: LeftMenuTableViewCell Lify Cicle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
}
