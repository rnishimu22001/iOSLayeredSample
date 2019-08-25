//
//  APIRequestable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case badURL
    case notHttpScheme
    case general(error: NSError?)
    case dataNotFound
    case responseNotFound
    case dataEncodeFailed
}

protocol APIRequestable {
    var configuration: URLSessionConfiguration { get }
    func request(with request: URLRequest, completion: @escaping (Result<Data, Error>, HTTPURLResponse?) -> Void)
}

extension APIRequestable {
    
    func request(with request: URLRequest, completion: @escaping (Result<Data, Error>, HTTPURLResponse?) -> Void) {
        
        guard request.url?.scheme == "https" else {
            completion(.failure(RequestError.notHttpScheme), nil)
            return
        }
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            session.invalidateAndCancel()
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(RequestError.responseNotFound), nil)
                return
            }
            
            guard error == nil else {
                completion(.failure(error!), httpResponse)
                return
            }
            
            guard let data = data else {
                completion(.failure(RequestError.dataNotFound), httpResponse)
                return
            }
            completion(.success(data), httpResponse)
        })
        task.resume()
    }
}

