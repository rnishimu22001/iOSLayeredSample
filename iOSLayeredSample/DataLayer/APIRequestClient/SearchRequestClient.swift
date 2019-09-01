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

protocol SearchRequestClientProtocol {
    func request(with url: String, sort: SearchSortPattern, query: String, completion: @escaping (_ result: Result<Repositories, Error>, _ response: GitHubAPIResponseHeader?) -> Void)
    func request(nextURL: String, completion: @escaping (_ result: Result<Repositories, Error>, _ response: GitHubAPIResponseHeader?) -> Void)
}

/// https://developer.github.com/v3/search/#search-users
struct SearchRequestClient: SearchRequestClientProtocol {
    
    let requester: HTTPRequestable
    
    init(requester: HTTPRequestable = HTTPRequester()) {
        self.requester = requester
    }
    
    func request(with url: String, sort: SearchSortPattern, query: String, completion: @escaping (_ result: Result<Repositories, Error>, _ response: GitHubAPIResponseHeader?) -> Void) {
        
        guard var components = URLComponents(string: url) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        
        let parameters = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "order", value: "desc")
        ]
        
        components.queryItems = parameters
        
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        let repositorySearchRequest = URLRequest(url: requestURL)
        request(repositorySearchRequest: repositorySearchRequest, completion: completion)
    }
    
    func request(nextURL: String, completion: @escaping (Result<Repositories, Error>, GitHubAPIResponseHeader?) -> Void) {
        guard
            let url = URL(string: nextURL) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        request(repositorySearchRequest: URLRequest(url: url), completion: completion)
    }
    
    private func request(repositorySearchRequest: URLRequest, completion: @escaping (_ result: Result<Repositories, Error>, _ response: GitHubAPIResponseHeader?) -> Void) {
        requester.request(with: repositorySearchRequest) { result, response in
            var responseHeader: GitHubAPIResponseHeader?
            if let header = response?.allHeaderFields {
                responseHeader = GitHubAPIResponseHeader(with: header)
            }
            switch result {
            case .failure(let error):
                completion(.failure(error), responseHeader)
            case .success(let data):
                guard let users = try? JSONDecoder().decode(Repositories.self, from: data) else {
                    completion(.failure(RequestError.dataEncodeFailed), responseHeader)
                    return
                }
                completion(.success(users), responseHeader)
            }
        }
    }
}
