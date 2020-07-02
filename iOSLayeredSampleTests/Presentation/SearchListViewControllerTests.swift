//
//  SearchListViewControllerTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
import XCTest
@testable import iOSLayeredSample

final class SearchListViewControllerTest: XCTestCase {
    
    func testSearchViewDelegate() {
        // Given
        let viewModel = MockSearchListViewModel()
        let navigator = SpyNavigator()
        let target = SearchListViewController()
        target.navigator = navigator
        target.viewModel = viewModel
        let repositoryName = "test"
        // When
        let repository = Repository(fullName: repositoryName, description: nil, starCount: 100)
        viewModel.stubbedRepositoryInListResult = RepositoryDisplayData(from: repository)
        target.searchListView(SearchListView(parentView: UIView()),
                              didSelectRepositoryListAt: 0)
        // Then
        XCTAssertEqual(navigator.invokedPushCount, 1, "画面が一回pushされること")
        XCTAssertTrue(navigator.invokedPushParametersList.first!.viewControler is DetailViewController, "詳細画面がpushされること")
        XCTAssertEqual((navigator.invokedPushParametersList.first!.viewControler as?  DetailViewController)!.repositoryFullName, repositoryName, "Repository名が代入されていること")
    }
}
