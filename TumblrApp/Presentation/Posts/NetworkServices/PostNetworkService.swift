//
//  DashboardNetworkService.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

struct PostNetworkService: APIClientProtocol {
    
    func fetchPosts(parameters: ApiParametersProtocol,completion: @escaping (PostResponse?, Error?) -> ()) {
        let request = RequestGenerator<PostResponse>(type: APIRequestType.get, encodingType: .url, endPoint: EndPoint.getPosts, parameters: parameters)
        
        fetch(request: request, isShowProgressHud: true) { (postResponse, error) in
            completion(postResponse, error)
        }
    }
}


