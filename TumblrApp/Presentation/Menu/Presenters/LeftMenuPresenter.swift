//
//  LeftMenuPresenter.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class LeftMenuPresenter {
   
    //MARK: Variables
    
    private var menuItems = [LeftMenuModel]()
    var tableViewGenerator: TableViewGenerator<LeftMenuPresenter>?
    weak var delegate: LeftMenuView?
    
    init() {
        tableViewGenerator = TableViewGenerator<LeftMenuPresenter>(dataSource: menuItems, responder: self)
    }
    
    //MARK: Public Methods
    
    func fetchMenuItems() {
        let publicationsItem = LeftMenuModel(name: "Posts",
                                             iconImageName: "publicationstIcon",
                                             itemType: .publications)
        let profileItem = LeftMenuModel(name: "Profile",
                                        iconImageName: "profileIcon",
                                        itemType: .profile)
        
        
        menuItems = [publicationsItem, profileItem]
        tableViewGenerator?.update(dataSource: menuItems)
        delegate?.update()
    }
}

//MARK: TableViewGenerable Delegate

extension LeftMenuPresenter: TableViewGenerable {
    typealias Item = LeftMenuModel
    typealias Cell = LeftMenuTableViewCell
    
    func didSelect(item: LeftMenuModel, index: Int) {
        delegate?.showViewController(with: item.itemType )
    }
}
