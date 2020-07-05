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
    
    struct Container {
        // Given
        let profile = MockCommunityProfileRepository()
        let release = MockReleaseReposiotry()
        let collaborator = MockCollaboratorRepository()
        let branch = MockBranchesRepository()
        let useCase: DetailUseCaseProtocol
        let target: DetailViewModel
        init() {
            useCase = DetailUseCase(profileRepository: profile,
                                    releaseRepository: release,
                                    collaboratorRepository: collaborator,
                                    branchRepository: branch)
            target = DetailViewModel(repositoryFullName: "testRepository",
                                     useCase: useCase)
        }
    }
    
    let branches = [Branch(name: "test", isProtected: false)]
    let release = Release(tagName: "test", releaseDesciption: nil, publishedDate: "today", isDraft: false, isPreRelease: false)
    let collaborators = [Collaborator(isAdmin: true, icon: URL(string: "https://test.com")!, name: "test1"),
                         Collaborator(isAdmin: false, icon: URL(string: "https://test.com")!, name: "test2"),
    
                         Collaborator(isAdmin: true, icon: URL(string: "https://test.com")!, name: "test3"),
    
                         Collaborator(isAdmin: true, icon: URL(string: "https://test.com")!, name: "test4"),
    
                         Collaborator(isAdmin: true, icon: URL(string: "https://test.com")!, name: "test5"),
    
                         Collaborator(isAdmin: true, icon: URL(string: "https://test.com")!, name: "test6")]
    
    func testInitalized() {
        // Given When
        let target = DetailViewModel(repositoryFullName: "test")
        // Then
        XCTAssertTrue(target.contents.isEmpty, "初期化時は空")
        XCTAssertEqual(target.status, .initalized, "最初は初期化状態になること")
    }
    
    func testReload() {
        // Given
        let container = Container()
        // When
        container.target.reload()
        // Then
        XCTAssertTrue(container.target.contents.isEmpty, "reloadでは表示データは追加されない")
        XCTAssertEqual(container.target.status, .loading, "reload後はloadingの表示になること")
    }
    
    func testDidLoadProfile() {
        XCTContext.runActivity(named: "リクエスト成功", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.profile.stubbedReloadResult.send(CommunityProfile(name: "test",
                                                              license: nil,
                                                              repositoryDescription: "this is test",
                                                              lastUpdate: "2020-07-01"))
            // Then
            XCTAssertEqual(container.profile.invokedReloadCount, 1)
            XCTAssertNotNil(container.target.profile, "一番上にCommunityProfileが表示されること")
            XCTAssertNotNil(container.target.pagingLoading, "その他のモジュールがロードされていないのでロード中の表示がされること")
            XCTAssertNil(container.target.branch, "データ更新が起こらないこと")
            XCTAssertNil(container.target.release, "データ更新が起こらないこと")
            XCTAssertNil(container.target.collaborators, "データ更新が起こらないこと")
            XCTAssertEqual(container.target.status, .browsable, "ステータスが表示可能で更新されること")
        })
        XCTContext.runActivity(named: "OhterModulesリクエスト成功後にProfileのリクエストが成功", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.branch.stubbedReloadBranchesResult.send(branches)
            container.release.stubbedReloadLatestReleaseResult.send(release)
            container.collaborator.stubbedReloadResult.send(collaborators)
            container.profile.stubbedReloadResult.send(CommunityProfile(name: "test",
                                                                        license: nil,
                                                                        repositoryDescription: "this is test",
                                                                        lastUpdate: "2020-07-01"))
            // Then
            XCTAssertNotNil(container.target.profile, "Profileのデータが1番目に表示されること")
            XCTAssertNil(container.target.pagingLoading, "Loadingの表示が含まれない")
        })
        XCTContext.runActivity(named: "リクエスト失敗", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.profile.stubbedReloadResult.send(completion: .failure(ErrorReason.general))
            // Then
            XCTAssertNil(container.target.profile, "エラーの場合はデータ更新が起こらないこと")
            XCTAssertEqual(container.target.status, .error, "ステータスがエラーで更新されること")
        })
    }
    
    func testDidLoadOtherModules() {
        
        XCTContext.runActivity(named: "OhterModulesのみリクエスト成功", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.branch.stubbedReloadBranchesResult.send(branches)
            container.release.stubbedReloadLatestReleaseResult.send(release)
            container.collaborator.stubbedReloadResult.send(collaborators)
            // Then
            XCTAssertEqual(container.branch.invokedReloadBranchesCount, 1)
            XCTAssertEqual(container.release.invokedReloadLatestReleaseCount, 1)
            XCTAssertEqual(container.collaborator.invokedReloadCount, 1)
            XCTAssertNotNil(container.target.branch, "Branchのデータが更新される")
            XCTAssertNotNil(container.target.release, "Releaseの情報が更新されること")
            XCTAssertNotNil(container.target.collaborators, "Collaboratorが更新されること")
            XCTAssertEqual(container.target.collaborators!.collaborators.count, 5, "Collaboratorsの表示データが最大5件に制限されること")
            XCTAssertNil(container.target.pagingLoading, "ロード中の情報が更新されないこと")
            XCTAssertEqual(container.target.status, .loading, "ステータスが更新がないこと")
        })
        XCTContext.runActivity(named: "OtherModulesすべてのリクエスト失敗", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.collaborator.stubbedReloadResult.send(completion: .failure(ErrorReason.general))
            container.branch.stubbedReloadBranchesResult.send(completion: .failure(ErrorReason.general))
            container.release.stubbedReloadLatestReleaseResult.send(completion: .failure(ErrorReason.general))
            // Then
            XCTAssertNil(container.target.branch, "エラーの場合はデータ更新が起こらないこと")
            XCTAssertNil(container.target.release, "エラーの場合はデータ更新が起こらないこと")
            XCTAssertNil(container.target.collaborators, "エラーの場合はデータ更新が起こらないこと")
            XCTAssertEqual(container.target.status, .loading, "ステータスが更新に影響がないこと")
        })
        XCTContext.runActivity(named: "OtherModulesのCollaboratorsのみリクエスト失敗", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.collaborator.stubbedReloadResult.send(completion: .failure(ErrorReason.general))
            container.branch.stubbedReloadBranchesResult.send(branches)
            container.release.stubbedReloadLatestReleaseResult.send(release)
            // Then
            XCTAssertNil(container.target.collaborators, "データが追加されないこと")
        })
        XCTContext.runActivity(named: "Profileのリクエスト成功後にOtherModulesのリクエストが成功", block: { _ in
            // Given
            let container = Container()
            // When
            container.target.reload()
            container.profile.stubbedReloadResult.send(CommunityProfile(name: "test",
                                                                        license: nil,
                                                                        repositoryDescription: "this is test",
                                                                        lastUpdate: "2020-07-01"))
            container.branch.stubbedReloadBranchesResult.send(branches)
            container.release.stubbedReloadLatestReleaseResult.send(release)
            container.collaborator.stubbedReloadResult.send(collaborators)
            
            // Then
            XCTAssertNil(container.target.pagingLoading, "Loadingの表示が含まれない")
        })
    }
}
