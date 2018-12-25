//
//  ProfileNetworkService.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation


struct ProfileNetworkService {
    
    private let oauthService = OAuthService()
    
    func fetchUserInfo(completion: @escaping (UserInfo?, Error?) -> ()) {
        let request = RequestGenerator<UserInfo>(type: APIRequestType.get, encodingType: .url, endPoint: EndPoint.userInfo, parameters: nil)
        
        oauthService.fetch(request: request, isShowProgressHud: true) { (userInfo, error) in
            completion(userInfo, error)
        }
    }
}


