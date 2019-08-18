//
//  ReleaseDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

enum ReleaseStatus: String {
    case draft
    case prerelease
    case release
    // TODO: move to viewmodel
    init(isDraft: Bool, isPrerelease: Bool) {
        if isDraft {
            self = .draft
        } else if isPrerelease {
            self = .prerelease
        } else {
            self = .release
        }
    }
    
    var color: UIColor {
        switch self {
        case .draft:
            return .secondaryLabel
        case .prerelease:
            return .black
        case .release:
            return .green
        }
    }
}

import Foundation

protocol ReleaseDisplayable {
    var tagName: String { get }
    var releaseDesciption: String { get }
    var status: ReleaseStatus { get }
    var publishedDate: String { get }
}

struct ReleaseDisplayData: ReleaseDisplayable {
    let tagName: String
    let releaseDesciption: String
    let status: ReleaseStatus
    let publishedDate: String
    
    init(with release: Release, status: ReleaseStatus) {
        tagName = release.name
        releaseDesciption = release.body
        self.status = status
        publishedDate = release.publishedAt.currentLocale
    }
}
