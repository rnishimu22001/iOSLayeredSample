//
//  .swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

// MARK: - Repositories
struct RepositoriesData: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryData]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Repository
struct RepositoryData: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let owner: Owner
    let itemPrivate: Bool
    let htmlURL: String
    let itemDescription: String?
    let fork: Bool
    let url: String
    let stargazersCount, watchersCount: Int
    let forksCount, openIssuesCount: Int
    let score: Double

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case fork, url
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case score
    }
}

extension RepositoryData {
    var converted: Repository {
        Repository(fullName: self.fullName,
                   description: self.itemDescription,
                   starCount: self.stargazersCount)
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, receivedEventsURL: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
    }
}
