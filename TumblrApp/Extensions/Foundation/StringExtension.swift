//
//  StringExtension.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

extension String {
    
    //detect date format and return date from string
    var detectDate: Date? {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        let matches = detector?.matches(in: self, options: [], range: NSMakeRange(0, self.utf16.count))
        return matches?.first?.date
    }
}
