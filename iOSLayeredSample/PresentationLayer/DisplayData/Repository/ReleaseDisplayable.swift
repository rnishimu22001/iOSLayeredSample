//
//  ReleaseDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

enum ReleaseStatus {
    case draft
    case prerelease
    case release
    
    init(isDraft: Bool, isPrerelease: Bool) {
        if isDraft {
            self = .draft
        } else if isPrerelease {
            self = .prerelease
        } else {
            self = .release
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
    
    init(with release: Release) {
        tagName = release.name
        releaseDesciption = release.body
        status = ReleaseStatus(isDraft: release.draft, isPrerelease: release.prerelease)
        publishedDate = release.publishedAt.currentLocale
    }
}
