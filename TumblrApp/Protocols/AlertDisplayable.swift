//
//  AlertDisplayable.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

import UIKit

protocol AlertDisplayable {
    func showAlert(with error: Error)
}

extension AlertDisplayable where Self: UIViewController {
    
    func showAlert(with error: Error) {
                
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


