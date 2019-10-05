//
//  BranchesRequestClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol BranchesRequestClientProtocol {
    func requestBranch(inRepository fullName: String, completion: @escaping ((Result<Branches, Error>, GitHubAPIResponseHeader?) -> Void))
}

struct BranchesRequestClient: BranchesRequestClientProtocol, GitHubAPIRequestable {
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func requestBranch(inRepository fullName: String, completion: @escaping ((Result<Branches, Error>, GitHubAPIResponseHeader?) -> Void)) {
        guard var urlComponents = URLComponents(string: APIURLSetting.BranchList.url(with: fullName)) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let query = URLQueryItem(name: "protected", value: "true")
        urlComponents.queryItems = [query]
        guard let url = urlComponents.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let request = URLRequest(url: url)
        self.request(request, completion: completion)
    }
}
