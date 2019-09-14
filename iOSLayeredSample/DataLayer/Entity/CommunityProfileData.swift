//
//  CommunityProfile.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

// MARK: - CommunityProfile
struct CommunityProfileData: Codable {
    let healthPercentage: Int?
    let communityProfileDescription: String?
    let documentation: Bool?
    let files: Files?
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case healthPercentage = "health_percentage"
        case communityProfileDescription = "description"
        case documentation, files
        case updatedAt = "updated_at"
    }
}

// MARK: - Files
struct Files: Codable {
    let codeOfConduct: CodeOfConduct
    let contributing, issueTemplate, pullRequestTemplate: Contributing
    let license: CodeOfConduct
    let readme: Contributing

    enum CodingKeys: String, CodingKey {
        case codeOfConduct = "code_of_conduct"
        case contributing
        case issueTemplate = "issue_template"
        case pullRequestTemplate = "pull_request_template"
        case license, readme
    }
}

// MARK: - CodeOfConduct
struct CodeOfConduct: Codable {
    let name, key: String
    let url: String
    let htmlURL: String
    let spdxID: String?

    enum CodingKeys: String, CodingKey {
        case name, key, url
        case htmlURL = "html_url"
        case spdxID = "spdx_id"
    }
}

// MARK: - Contributing
struct Contributing: Codable {
    let url, htmlURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
    }
}
