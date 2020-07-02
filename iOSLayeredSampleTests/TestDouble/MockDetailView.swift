//
//  MockDetailView.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/02.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import UIKit
@testable import iOSLayeredSample

final class MockDetailView: DetailViewProtocol {

    required init(with superView: UIView) {}

    var invokedUpdateContents = false
    var invokedUpdateContentsCount = 0
    var invokedUpdateContentsParameters: (contents: [Any], Void)?
    var invokedUpdateContentsParametersList = [(contents: [Any], Void)]()

    func update(contents: [Any]) {
        invokedUpdateContents = true
        invokedUpdateContentsCount += 1
        invokedUpdateContentsParameters = (contents, ())
        invokedUpdateContentsParametersList.append((contents, ()))
    }

    var invokedUpdateStatus = false
    var invokedUpdateStatusCount = 0
    var invokedUpdateStatusParameters: (status: ContentsStatus, Void)?
    var invokedUpdateStatusParametersList = [(status: ContentsStatus, Void)]()

    func update(status: ContentsStatus) {
        invokedUpdateStatus = true
        invokedUpdateStatusCount += 1
        invokedUpdateStatusParameters = (status, ())
        invokedUpdateStatusParametersList.append((status, ()))
    }
}
