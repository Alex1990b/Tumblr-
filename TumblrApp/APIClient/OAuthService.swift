//
//  OAuthService.swift
//  TumblrApp
//
//  Created by Sasha on 21.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation
import OAuthSwift


enum AuthKeys: String {
    case consumerKey     = "86kK9m5BLP6J1Dk5qRFatwUdcnqws2IBEBCO3wfMWqh8BdgvBK"
    case consumerSecret  = "iuxeXihDlDcIFoh33n2fXy2X6HmuzV4SWx4iz7r5Z4d3OdZe5a"
    case requestTokenUrl = "https://www.tumblr.com/oauth/request_token"
    case authorizeUrl    = "https://www.tumblr.com/oauth/authorize"
    case accessTokenUrl  = "https://www.tumblr.com/oauth/access_token"
    case redirectUrl     = "tumblr-callback://oauth-callback/tumblr"
}


final class OAuthService: APIClientProtocol {
    
    //MARK: Variables
    
    private var oauthswift: OAuth1Swift?
    
    init() {
        oauthswift = OAuth1Swift(
            consumerKey:     AuthKeys.consumerKey.rawValue,
            consumerSecret:  AuthKeys.consumerSecret.rawValue,
            requestTokenUrl: AuthKeys.requestTokenUrl.rawValue,
            authorizeUrl:    AuthKeys.authorizeUrl.rawValue,
            accessTokenUrl:  AuthKeys.accessTokenUrl.rawValue
        )
    }
    
    //MARK: Public Methods
    
    func authorize(completion:@escaping (_ error: Error? ) -> ()) {
        
        guard let redirectUrl = URL(string: AuthKeys.redirectUrl.rawValue) else { return }
        
        oauthswift?.authorize(
            withCallbackURL: redirectUrl,
            success: { credential, response, parameters in
                UserDefaults.standard.oauthToken = credential.oauthToken
                UserDefaults.standard.oauthTokenSecret = credential.oauthTokenSecret
                completion(nil)
        },
            failure: { error in
                completion(error)
        }
        )
    }
    
    func fetch<T>(request: T, isShowProgressHud: Bool, completion: @escaping (T.ResponseType?, Error?) -> ()) where T : APIRequestProtocol {
        
        oauthswift?.client.credential.oauthToken = UserDefaults.standard.oauthToken ?? ""
        oauthswift?.client.credential.oauthTokenSecret =  UserDefaults.standard.oauthTokenSecret ?? ""
        
        guard let urlSting = request.endPoint.url?.absoluteString else { return }
        
        if isShowProgressHud {
            show()
        }
        
        oauthswift?.client.request(urlSting, method: getHTTPMethod(with: request), success: { [weak self] (response) in
            self?.handle(request: request, isCloseProgressHud: isShowProgressHud, response: response, completion: { items in
                completion(items, nil)
            })
            }, failure: { [weak self] (error) in
                
                if isShowProgressHud {
                    self?.close()
                }
                completion(nil, error)
        })
    }
}

//MARK: Static Methods

extension OAuthService {
    static func handle(url: URL) {
        OAuthSwift.handle(url: url)
    }
}

//MARK: Pivate Methods

private extension OAuthService {
    
    func getHTTPMethod<T: APIRequestProtocol>(with request: T) -> OAuthSwiftHTTPRequest.Method {
        switch request.type {
        case .post:   return .POST
        case .get:    return .GET
        case .put:    return .PUT
        case .delete: return .DELETE
        }
    }
    
    func handle<T: APIRequestProtocol>(request: T, isCloseProgressHud: Bool, response: OAuthSwiftResponse, completion: (T.ResponseType?) -> () ) {
        
        if isCloseProgressHud {
            close()
        }
        
        if response.response.statusCode == 200 {
            
            do {
                let context = CoreDataService.shared.managedObjectContext
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = context
                let items = try decoder.decode(T.ResponseType.self, from: response.data)
                completion(items)
                
            } catch _ {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}
