//
//  UserInfo.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation


struct UserInfo: Decodable {
    var response: Response
    
    enum CodingKeys: String, CodingKey {
        case response  = "response"
    }
    
    struct Response: Decodable {
        var user: User
    
        enum CodingKeys: String, CodingKey {
            case user  = "user"
        }
    }
}
