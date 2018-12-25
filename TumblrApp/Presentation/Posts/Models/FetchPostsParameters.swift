//
//  FetchPostsParameters.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

struct FetchPostsParameters {
    var offset: Int
    var pageNumber: Int
}

extension FetchPostsParameters: ApiParametersProtocol {
    func convertToDictionary() -> [String : Any] {
        return ["type": "link", "offset": offset, "page_number": pageNumber ]
    }
}
