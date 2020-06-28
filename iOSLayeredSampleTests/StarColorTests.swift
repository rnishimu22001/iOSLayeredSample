//
//  StarColorTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/27.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import XCTest
@testable import iOSLayeredSample

// MARK: Domain Layer Tests
final class StarColorTests: XCTestCase {
    
    func testStarCount() {
        XCTContext.runActivity(named: "Star10000以上", block: { _ in
            XCTAssertEqual(StarColor(with: 10000), .red, "Starが多い場合は赤")
        })
        XCTContext.runActivity(named: "Star10000未満", block: { _ in
            XCTAssertEqual(StarColor(with: 9999), .lightGray, "Starが少ない場合はグレー")
        })
    }
}

// MARK: Presentation Layer Tests
extension StarColorTests {
    
    func testStarCountColor() {
        XCTAssertEqual(StarColor.red.color, .red, "Starが多い場合は赤色")
        XCTAssertEqual(StarColor.lightGray.color, .lightGray)
    }
}
