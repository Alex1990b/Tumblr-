//
//  TableViewExtension.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ : T.Type) where T: NibLoadableView {
     
            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: T.nibName, bundle: bundle)
            register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell & NibLoadableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
