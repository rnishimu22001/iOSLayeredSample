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
        let profile = MockCommunityProfileRepository()
        let release = MockReleaseReposiotry()
        let collaborator = MockCollaboratorRepository()
        let branch = MockBranchesRepository()
        let useCase = DetailUseCase(profileRepository: profile,
                                    releaseRepository: release,
                                    collaboratorRepository: collaborator,
                                    branchRepository: branch)
        let target = DetailViewModel(repositoryFullName: repositoryName,
                                     useCase: useCase)
        // When
        target.reload()
        // Then
        // 各Repositoryが一回reloadのメソッドが呼ばれること
        XCTAssertEqual(profile.invokedReloadCount, 1)
        XCTAssertEqual(branch.invokedReloadBranchesCount, 1)
        XCTAssertEqual(collaborator.invokedReloadCount, 1)
        XCTAssertEqual(release.invokedReloadLatestReleaseCount, 1)
        
    }

}
