//
//  CollaboratorsClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol CollaboratorsClientProtocol {
    func requestCollaborators(repository fullName: String, completion: @escaping ((Result<[CollaboratorData], Error>, GitHubAPIResponseHeader?) -> Void))
}

struct CollaboratorsClient: CollaboratorsClientProtocol, GitHubAPIRequestable {
    
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func requestCollaborators(repository fullName: String, completion: @escaping ((Result<[CollaboratorData], Error>, GitHubAPIResponseHeader?) -> Void)) {
        let url = APIURLSetting.Collaborators.url(with: fullName)
        guard var components = URLComponents(string: url) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let affiliation = URLQueryItem(name: "affiliation", value: "outside")
        components.queryItems?.append(affiliation)
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let apiRequest = APIURLSetting.Collaborators.addAccept(request: URLRequest(url: requestURL))
        request(apiRequest, completion: completion)
    }
}
