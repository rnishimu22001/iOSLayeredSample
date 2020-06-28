//
//  StarColor.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

enum StarCount {
    case red
    case lightGray
    
    init(with count: Int) {
        switch count {
        case 10000...Int.max:
            self = .red
        case 0..<10000:
            self = .lightGray
        default:
            fatalError()
        }
    }
}

