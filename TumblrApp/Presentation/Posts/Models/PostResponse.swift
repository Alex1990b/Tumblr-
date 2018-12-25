//
//  Post.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

struct PostResponse: Decodable {
    var response: Response
    
    enum CodingKeys: String, CodingKey {
        case response  = "response"
    }
    
    struct Response: Decodable {
        var posts: [Post]
        var links: Links?
        
        enum CodingKeys: String, CodingKey {
            case posts  = "posts"
            case links = "_links"
        }
        
        struct Links: Decodable {
            var next: Next
            
            enum CodingKeys: String, CodingKey {
                case next = "next"
            }
            
            struct Next: Decodable {
                var queryParams: QueryParameters
                
                enum CodingKeys: String, CodingKey {
                    case queryParams  = "query_params"
                }
                
                struct QueryParameters: Decodable {
                    var offset: String
                    var pageNumber: String
                    
                    enum CodingKeys: String, CodingKey {
                        case offset     = "offset"
                        case pageNumber = "page_number"
                    }
                }
            }
        }
    }
}
