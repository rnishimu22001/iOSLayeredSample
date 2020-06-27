//
//  ReleaseStatusTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/27.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import XCTest
@testable import iOSLayeredSample

final class ReleaseStatusTests: XCTestCase {
    
    func testColor() {
        XCTAssertEqual(ReleaseStatus.draft.color, .secondaryLabel)
        XCTAssertEqual(ReleaseStatus.prerelease.color, .black)
        XCTAssertEqual(ReleaseStatus.release.color, .green)
    }
    
    func testStatus() {
        XCTContext.runActivity(named: "draftかつ、prereleaseの場合", block: { _ in
            XCTAssertEqual(ReleaseStatus(isDraft: true, isPrerelease: true), .draft, "prereleaseよりもdraftが優先される")
        })
        XCTContext.runActivity(named: "prereleaseの場合", block: { _ in
            XCTAssertEqual(ReleaseStatus(isDraft: false, isPrerelease: true), .prerelease, "prereleaseが反映される")
        })
        XCTContext.runActivity(named: "draft,prereleaseどちらでもない場合", block: { _ in
            XCTAssertEqual(ReleaseStatus(isDraft: false, isPrerelease: false), .release, "releaseになる")
        })
    }
}
