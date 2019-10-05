//
//  APISettings.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

struct APIURLSetting {
    static let base = "https://api.github.com/"
    static let userSearch = base + "search/users"
    static let repositorySearch = base + "search/repositories"
    
    struct HeaderKey {
        static let accept = "Accept"
    }
    
    struct CommunityProfile {
        static func addAccept(request: URLRequest) -> URLRequest {
            var mutable = request
            mutable.addValue("application/vnd.github.black-panther-preview+json", forHTTPHeaderField: HeaderKey.accept)
            return  mutable
        }
        
        static func url(with fullName: String) -> String {
            return base + "repos/" + fullName + "/community/profile"
        }
    }
    
    struct Collaborators {
        static func url(with fullName: String) -> String {
            return base + "repos/" + fullName + "/stats/contributors"
        }
    }
    
    struct Release {
        static func latestReleasesURL(with fullName: String) -> String {
            return base + "repos/" + fullName + "/releases/latest"
        }
    }
    
}
