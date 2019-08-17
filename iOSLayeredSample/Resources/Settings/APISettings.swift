//
//  APISettings.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

struct APIURLSetting {
    static let base = "https://api.github.com/"
    static let userSearch = base + "search/users"
    static let repositorySearch = base + "search/repositories"
    
    static func communityProfile(with fullName: String) -> String {
        return base + "/repos/" + fullName + "/community/profile"
    }
    static func collaborators(with fullName: String) -> String {
        return base + "/repos/" + fullName + "/collaborators"
    }
    static func latestReleases(with fullName: String) -> String {
        return base + "/repos/" + fullName + "/releases/latest"
    }
}
