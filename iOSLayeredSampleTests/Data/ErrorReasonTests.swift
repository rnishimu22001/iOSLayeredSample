//
//  ErrorReasonTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/28.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import XCTest
@testable import iOSLayeredSample

// MARK: Domain Layer Tests
final class ErrorReasonTests: XCTestCase {
    
    func testInit() {
        XCTContext.runActivity(named: "400番台", block: { _ in
            XCTAssertEqual(ErrorReason(with: 404), .clinetError, "400の場合はリクエストが不正")
        })
        XCTContext.runActivity(named: "500番台", block: { _ in
            XCTAssertEqual(ErrorReason(with: 503), .serverError, "500の場合はサーバー側")
        })
        XCTContext.runActivity(named: "その他", block: { _ in
            XCTAssertEqual(ErrorReason(with: 100), .general, "判別できない場合はgeneral")
        })
    }
}
