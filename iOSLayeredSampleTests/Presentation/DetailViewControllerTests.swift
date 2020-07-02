//
//  DetailViewControllerTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/02.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//


import Combine
import XCTest
@testable import iOSLayeredSample

final class DetailViewControllerTests: XCTestCase {
    
    let testName = "testTitle"
    
    func testLoadView() {
        
    }

    func testViewDidLoad() {
        // Given
        let target = DetailViewController()
        let viewModel = MockDetailViewModel()
        let view = MockDetailView(with: UIView())
        target.repositoryFullName = testName
        target.viewModel = viewModel
        target.detailView = view
        // When
        target.viewDidLoad()
        // Then
        XCTAssertEqual(target.navigationItem.backBarButtonItem?.title, "", "空文字が設定されること")
        XCTAssertEqual(target.navigationItem.title, testName, "titleにRepository名が設定されること")
        XCTAssertEqual(viewModel.invokedReloadCount, 1, "reloadが一回呼ばれること")
    }
}
