//
//  DateFormatterExtension.swift
//  Vixinity
//
//  Created by Sasha on 29.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

enum DateFormatType: String {
    case yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
}

extension DateFormatter {
    static var dateFormatter = DateFormatter()
    
    static func dateFormatter(with format: DateFormatType ) -> DateFormatter {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }
    
}

