//
//  TableViewGenerator.swift
//  Vixinity
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class TableViewGenerator<T: TableViewGenerable>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    
    private weak var responder: T?
    private var dataSource: [T.Item]!
    
    init(dataSource: [T.Item], responder: T) {
        self.dataSource = dataSource
        self.responder = responder
        super.init()
    }
    
    //MARK: Public Methods
    
    func update(dataSource: [T.Item]) {
        self.dataSource.append(contentsOf: dataSource)
    }
    
    func removeAll() {
        dataSource.removeAll()
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            responder?.loadNewItems()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        responder?.didSelect(item: dataSource[indexPath.row], index: indexPath.row)
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.Cell.defaultReuseIdentifier, for: indexPath) as? T.Cell   else { return UITableViewCell() }
        responder?.cellForRow(cell: cell, index: indexPath.row)
        cell.tag = indexPath.row
        let item = dataSource[indexPath.row]
        cell.configure(item, at: indexPath)
        
        return cell
    }
}


