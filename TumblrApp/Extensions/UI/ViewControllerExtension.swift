//
//  ViewControllerExtension.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

extension UIViewController: AlertDisplayable, StoryboardIdentifiable {
   
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}




