//
//  NibLoadableView.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol  TableViewDataSource {}

protocol ConfigurableCell: NibLoadableView {
    
    associatedtype T
    func configure(_ item: T, at indexPath: IndexPath)
}

protocol NibLoadableView: class {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}
