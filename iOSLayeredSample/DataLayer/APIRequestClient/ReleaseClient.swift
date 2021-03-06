//
//  ReleaseClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol ReleaseClientProtocol {
    func requestLatestRelease(repository fullName: String, completion: @escaping ((Result<ReleaseData, Error>, GitHubAPIResponseHeader?) -> Void))
}

struct ReleaseClient: ReleaseClientProtocol, GitHubAPIRequestable {
    
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func requestLatestRelease(repository fullName: String, completion: @escaping ((Result<ReleaseData, Error>, GitHubAPIResponseHeader?) -> Void)) {
        let url = APIURLSetting.Release.latestReleasesURL(with: fullName)
        guard let components = URLComponents(string: url) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        request(URLRequest(url: requestURL), completion: completion)
    }
}
