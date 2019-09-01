//
//  GitHubAPIRequestable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/09/01.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation



protocol GitHubAPIRequestable { }

extension GitHubAPIRequestable {
    func addAccept(request: URLRequest) ->URLRequest {
        var mutable = request
        mutable.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return  mutable
    }
}
