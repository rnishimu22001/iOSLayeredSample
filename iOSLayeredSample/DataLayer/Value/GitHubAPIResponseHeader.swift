//
//  GitHubAPIResponseHeader.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/12.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

struct GitHubAPIResponseHeader {
    
    struct Key {
        static let link = "Link"
    }
    
    private(set) var nextURL: String?
    private(set) var lastURL: String?
    
    init(with responseHeader: [AnyHashable: Any]) {
        guard let header = responseHeader as? [String: Any] else {
            fatalError()
        }
        
        if let linksString = header[Key.link] as? String {
            let links = linksString.split(separator: ",")
            links.forEach {
                guard
                    let startIndex = $0.range(of: "<")?.upperBound,
                    let endIndex = $0.range(of: ">")?.lowerBound else {
                        return
                }
                
                if $0.contains("rel=\"next\"") {
                    self.nextURL = String($0[startIndex..<endIndex])
                } else if $0.contains("rel=\"last\"") {
                    self.lastURL = String($0[startIndex..<endIndex])
                }
            }
        }
    }
}
