//
//  StoryboardExtension.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case auth       = "Login"
    case menu       = "Menu"
    case profile    = "Profile"
    case postDetail = "PostDetail"
    case savedPost  = "SavedPosts"
}

extension UIStoryboard {
    static func getStoryboard(by name: StoryboardName, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<VC: UIViewController>(from storyboardName: StoryboardName? = nil) -> VC  {
        
        var storyboard: UIStoryboard?
        
        if let storyboardName = storyboardName {
            storyboard = UIStoryboard.getStoryboard(by: storyboardName)
        } else {
            storyboard = self
        }
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: VC.storyboardIdentifier)
            as? VC else {
                fatalError("Couldn't instantiate view controller with identifier \(VC.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
