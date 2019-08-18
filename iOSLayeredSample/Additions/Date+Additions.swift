//
//  Date+Additions.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

extension Date {
    var currentLocale: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
}
