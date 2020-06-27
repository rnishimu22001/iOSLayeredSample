//
//  ReleaseStatus.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/06/27.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

enum ReleaseStatus: String {
    
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
