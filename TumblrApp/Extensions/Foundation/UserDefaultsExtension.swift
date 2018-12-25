//
//  UserDefaultsExtension.swift
//  TumblrApp
//
//  Created by Alex on 21.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var oauthToken: String? {
        get {
            return string(forKey: #function)
        }
        
        set {
            set(newValue, forKey: #function)
        }
    }
    
    var oauthTokenSecret: String? {
        get {
            return string(forKey: #function)
        }
        
        set {
            set(newValue, forKey: #function)
        }
    }
}


