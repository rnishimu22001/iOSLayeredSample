//
//  CommunityProfileClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol CommunityProfileClientProtocol {
    func requestProfile(repository fullName: String, completion: @escaping ((Result<CommunityProfile, Error>, GitHubAPIResponseHeader?) -> Void))
}

struct CommunityProfileClient: CommunityProfileClientProtocol, GitHubAPIRequestable {
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func requestProfile(repository fullName: String, completion: @escaping ((Result<CommunityProfile, Error>, GitHubAPIResponseHeader?) -> Void)) {
        let url = APIURLSetting.communityProfile(with: fullName)
        guard let components = URLComponents(string: url) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let apiRequest = addAccept(request: URLRequest(url: requestURL))
        request(apiRequest, completion: completion)
    }
}
