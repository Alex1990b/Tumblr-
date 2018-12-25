//
//  TableViewGenerable.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol TableViewGenerable: class {
    associatedtype Item: TableViewDataSource
    associatedtype Cell: UITableViewCell & ConfigurableCell where Cell.T == Item
    var tableViewGenerator: TableViewGenerator<Self>? { get set }
    
    func didSelect(item: Item, index: Int)
    func cellForRow(cell: Cell, index: Int)
    func loadNewItems()
}

extension TableViewGenerable {
    func loadNewItems() { }
    func cellForRow(cell: Cell, index: Int) { }
}
