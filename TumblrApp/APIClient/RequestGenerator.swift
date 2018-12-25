//
//  RequestGenerator.swift
//  APIClient
//
//  Created by Alex on 22.08.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

struct RequestGenerator<T: Decodable>: APIRequestProtocol  {
    
    typealias ResponseType = T
    
    var type: APIRequestType
    var encodingType: EncodingType
    var endPoint: EndPointProtocol
    var parameters: ApiParametersProtocol?
    
    init(type: APIRequestType, encodingType: EncodingType, endPoint: EndPointProtocol, parameters: ApiParametersProtocol?) {
        self.type = type
        self.encodingType = encodingType
        self.endPoint = endPoint
        self.parameters = parameters
    }
}
