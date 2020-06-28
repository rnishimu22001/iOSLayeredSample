//
//  StarCount.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

enum StarCount {
    case many
    case few
    
    init(with count: Int) {
        switch count {
        case 10000...Int.max:
            self = .many
        case 0..<10000:
            self = .few
        default:
            fatalError()
        }
    }
}

