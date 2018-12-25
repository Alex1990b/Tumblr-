//
//  LeftMenuModel.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

struct LeftMenuModel: TableViewDataSource {
    
    enum ItemType {
        case publications
        case profile
    }
    
    var name: String
    var iconImageName: String
    var itemType: ItemType
}

