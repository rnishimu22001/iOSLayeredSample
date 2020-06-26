//
//  GitHubAPIRequestable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/09/01.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol GitHubAPIRequestable {
    var requester: HTTPRequestable { get }
}

extension GitHubAPIRequestable {
    
    func request<T: Codable>(_ request: URLRequest, completion: @escaping ((Result<T, Error>, GitHubAPIResponseHeader?) -> Void)) {
        requester.request(with: request) { result, response in
            var header: GitHubAPIResponseHeader?
            if let headerFiled = response?.allHeaderFields {
                header = GitHubAPIResponseHeader(with: headerFiled)
            }
            switch result {
            case .failure(let error):
                completion(.failure(error), header)
            case .success(let data):
                do {
                    let profile = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(profile), header)
                } catch(let error) {
                    completion(.failure(error), header)
                }
            }
        }
    }
}
