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

struct ReleaseDisplayData {
    let tagName: String
    let releaseDesciption: String
    let status: ReleaseStatus
    let publishedDate: String
    
    init(with release: Release, status: ReleaseStatus) {
        tagName = release.tagName
        releaseDesciption = release.releaseDesciption ?? ""
        self.status = status
        publishedDate = release.publishedDate.currentLocale
    }
}
