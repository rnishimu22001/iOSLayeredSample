//
//  RepositoryReleaseClient.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol RepositoryReleaseClientProtocol {
    func requestLatestRelease(repository fullName: String, completion: @escaping ((Result<Release, Error>, URLResponse?) -> Void))
}

final class RepositoryReleaseClient: RepositoryReleaseClientProtocol, APIRequestable {
    let configuration: URLSessionConfiguration = .default
    
    func requestLatestRelease(repository fullName: String, completion: @escaping ((Result<Release, Error>, URLResponse?) -> Void)) {
        let url = APIURLSetting.collaborators(with: fullName)
        guard let components = URLComponents(string: url) else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        
        guard let requestURL = components.url else {
            completion(.failure(RequestError.badURL), nil)
            return
        }
        
        request(with: URLRequest(url: requestURL)) { result, response in
            switch result {
            case .failure(let error):
                completion(.failure(error), response)
            case .success(let data):
                guard let release = try? JSONDecoder().decode(Release.self, from: data) else {
                    completion(.failure(RequestError.dataEncodeFailed), response)
                    return
                }
                completion(.success(release), response)
            }
        }
    }
}
