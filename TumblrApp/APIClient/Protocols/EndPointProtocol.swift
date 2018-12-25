//
//  File.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? { get}
}

extension EndPointProtocol {
    var baseURL: String {
        return "https://api.tumblr.com/v2/"
    }
}

enum EndPoint: String, EndPointProtocol {
    
    case getPosts = "blog/staff.tumblr.com/posts/link?api_key=86kK9m5BLP6J1Dk5qRFatwUdcnqws2IBEBCO3wfMWqh8BdgvBK"
    case userInfo = "user/info"
    
    var url: URL? {
        return URL(string: baseURL + self.rawValue)
    }
}



