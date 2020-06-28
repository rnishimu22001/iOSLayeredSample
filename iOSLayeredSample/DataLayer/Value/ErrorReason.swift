//
//  ErrorReason.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/30.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

enum ErrorReason: Error {
    
    typealias ErrorCode = Int
    case clientError /// 400
    case serverError /// 500
    case general
    
    init(with code: ErrorCode) {
        switch code {
        case 400..<500:
            self = .clientError
        case _ where (500..<600).contains(code):
            self = .serverError
        default:
            self = .general
        }
    }
}
