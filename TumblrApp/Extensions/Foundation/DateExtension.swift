//
//  DateExtension.swift
//  Vixinity
//
//  Created by Alex on 23.09.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(expectedFormat: DateFormatType) -> String {
        
        let dateFormatter = DateFormatter.dateFormatter(with: expectedFormat)
        return dateFormatter.string(from: self)
    }
}

