//
//  NetworkRechabilityService.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Alamofire

final class Connectivity {
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
