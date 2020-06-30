//
//  SearchListViewModelTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/28.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
import XCTest
@testable import iOSLayeredSample

final class SearchListViewModelTests: XCTestCase {
    
    let dummyRepositories = [
        Repository(fullName: "test1", description: nil, starCount: 1),
        Repository(fullName: "test2", description: nil, starCount: 2),
        Repository(fullName: "test3", description: nil, starCount: 3)
    ]
    
    func testUpdateQuery() {
        // Given
        let query = "test"
        XCTContext.runActivity(named: "リクエスト成功 ", block: { _ in
            XCTContext.runActivity(named: "追加読み込み可能", block: { _ in
                let nextURL = URL(string: "https://next.for.test.com")!
                let mock = MockSearchListUseCase()
                let target = SearchListViewModel(useCase: mock)
                mock.stubbedUpdateResult = .init()
                // Then
                XCTAssertEqual(target.status.value, .initalized, "作成時のstatusはinitalized")
                // When
                target.update(searchQuery: query)
                // Then
                XCTAssertEqual(mock.invokedUpdateCount, 1, "queryのupdateがされること")
                XCTAssertEqual(mock.invokedUpdateParameters!.searchQuery, query)
                XCTAssertEqual(mock.invokedLoadCount, 0, "追加読みこみはよばれないこと")
                XCTAssertEqual(target.status.value, .loading, "リクエスト中のstatusはloading")
                // When
                mock.stubbedUpdateResult.send((result: dummyRepositories, nextURL: nextURL))
                mock.stubbedUpdateResult.send(completion: .finished)
                // Then
                XCTAssertEqual(target.status.value, .browsable, "リクエスト完了後はstatusはbrowsable")
                XCTAssertEqual(target.contents.value.filter { $0 is RepositoryDisplayData }.count, dummyRepositories.count, "リポジトリの表示用データが3件")
                XCTAssertTrue(target.contents.value.last is LoadingDisplayData, "末尾にローディングのデータが追加される")
                XCTAssertEqual(target.contents.value.filter { $0 is LoadingDisplayData }.count, 1, "末尾にローディングのデータは1件であること")
            })
            XCTContext.runActivity(named: "追加読み込みできない", block: { _ in
                let mock = MockSearchListUseCase()
                let target = SearchListViewModel(useCase: mock)
                mock.stubbedUpdateResult = .init()
                // When
                target.update(searchQuery: query)
                mock.stubbedUpdateResult.send((result: dummyRepositories, nextURL: nil))
                mock.stubbedUpdateResult.send(completion: .finished)
                // Then
                XCTAssertEqual(target.status.value, .browsable, "リクエスト完了後はstatusはbrowsable")
                XCTAssertEqual(target.contents.value.filter { $0 is RepositoryDisplayData }.count, dummyRepositories.count, "リポジトリの表示用データが3件")
                XCTAssertEqual(target.contents.value.filter { $0 is LoadingDisplayData }.count, 0, "末尾にローディングのデータが追加されない")
            })
        })
        
        XCTContext.runActivity(named: "リクエスト失敗", block: { _ in
            let mock = MockSearchListUseCase()
            let target = SearchListViewModel(useCase: mock)
            mock.stubbedUpdateResult = .init()
            // When
            target.update(searchQuery: query)
            mock.stubbedUpdateResult.send(completion: .failure(ErrorReason.general))
            // Then
            XCTAssertEqual(target.status.value, .error, "リクエスト失敗でerror")
        })
    }
}
