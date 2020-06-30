//
//  DetailViewModelTests.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/30.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
import XCTest
@testable import iOSLayeredSample

final class DetailViewModelTests: XCTestCase {
    
    let repositoryName = "testRepository"
    
    func testReload() {
        // Given
        let useCase = MockDetailUseCase()
        let target = DetailViewModel(repositoryFullName: repositoryName,
                                     useCase: useCase)
        // When
        target.reload()
        // Then
        XCTAssertEqual(useCase.invokedReloadCount, 1, "reloadのメソッドが呼ばれること")
        
    }

}
