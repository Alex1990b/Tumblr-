//
//  File.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation


enum EncodingType {
    case url
    case json
    case query
}

enum APIRequestType {
    case post
    case get
    case put
    case delete
}

protocol APIRequestProtocol {
    
    associatedtype ResponseType: Decodable
    var type: APIRequestType { get }
    var encodingType: EncodingType { get }
    var endPoint: EndPointProtocol { get }
    var parameters: ApiParametersProtocol? { get set }
}

