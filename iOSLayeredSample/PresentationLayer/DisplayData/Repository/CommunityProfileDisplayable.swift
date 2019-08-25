//
//  CommunityProfileDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol CommunityProfileDisplayable: Displayable {
    var name: String { get }
    var repositoryDescription: String { get }
    var license: String { get }
    var lastUpdate: String { get }
}

struct CommunityProfileDisplayData: CommunityProfileDisplayable {
    let name: String
    let license: String
    let repositoryDescription: String
    let lastUpdate: String
    
    init(with profile: CommunityProfile) {
        name = profile.files.codeOfConduct.name
        repositoryDescription = profile.communityProfileDescription
        license = profile.files.license.name
        lastUpdate = profile.updatedAt.currentLocale
    }
}
