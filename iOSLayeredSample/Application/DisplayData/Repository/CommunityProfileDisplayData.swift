//
//  CommunityProfileDisplayData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

struct CommunityProfileDisplayData: Identifiable {
   
    let id = UUID()
    
    let name: String
    let license: String
    let repositoryDescription: String
    let lastUpdate: String
    
    init(with profile: CommunityProfile) {
        name = profile.name
        repositoryDescription = profile.repositoryDescription ?? ""
        license = profile.license ?? ""
        lastUpdate = profile.lastUpdate
    }
}
