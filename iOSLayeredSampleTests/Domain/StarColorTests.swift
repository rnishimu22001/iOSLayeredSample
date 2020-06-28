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
            XCTAssertEqual(StarCount(with: 10000), .many, "Starが多い場合は赤")
        })
        XCTContext.runActivity(named: "Star10000未満", block: { _ in
            XCTAssertEqual(StarCount(with: 9999), .few, "Starが少ない場合はグレー")
        })
    }
}

// MARK: Presentation Layer Tests
extension StarColorTests {
    
    func testStarCountColor() {
        XCTAssertEqual(StarCount.many.color, .red, "Starが多い場合は赤色")
        XCTAssertEqual(StarCount.few.color, .lightGray)
    }
}
