//
//  ReleaseDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

extension ReleaseStatus {
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

struct ReleaseDisplayData: Identifiable {
    let id = UUID()
    let tagName: String
    let releaseDesciption: String
    let status: ReleaseStatus
    let publishedDate: String
    
    init(with release: Release, status: ReleaseStatus) {
        tagName = release.tagName
        releaseDesciption = release.releaseDesciption ?? ""
        self.status = status
        publishedDate = release.publishedDate
    }
}
