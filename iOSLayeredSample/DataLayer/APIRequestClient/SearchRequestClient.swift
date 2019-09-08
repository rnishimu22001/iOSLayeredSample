//
//  SearchRequestClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

enum SearchSortPattern: String {
    case stars
    case forks
}

protocol SearchRequestClientInterface {
    func request(url: URL?, sort: SearchSortPattern?, query: String?, completion: @escaping (Result<Repositories, Error>, GitHubAPIResponseHeader?) -> Void)
}

/// https://developer.github.com/v3/search/#search-users
struct SearchRequestClient: SearchRequestClientInterface, GitHubAPIRequestable {
    
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func request(url: URL? = nil, sort: SearchSortPattern?, query: String?, completion: @escaping (Result<Repositories, Error>, GitHubAPIResponseHeader?) -> Void) {
        var requestBaseURL: URL
        if let nextURL = url {
            requestBaseURL = nextURL
        } else if let entryPoint = URL(string: APIURLSetting.repositorySearch) {
            requestBaseURL = entryPoint
        } else {
            return
        }
        
        guard var components = URLComponents(url: requestBaseURL, resolvingAgainstBaseURL: true) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        if let searchQuery = query, let sortPattern = sort {
            let parameters = [
                URLQueryItem(name: "q", value: searchQuery),
                URLQueryItem(name: "sort", value: sortPattern.rawValue),
                URLQueryItem(name: "order", value: "desc")
            ]
            components.queryItems = parameters
        }
        
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let repositorySearchRequest = URLRequest(url: requestURL)
        request(repositorySearchRequest, completion: completion)
    }
}
