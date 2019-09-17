//
//  Release.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

// MARK: - Release
struct ReleaseData: Codable {
    let url: String
    let htmlURL: String
    let assetsURL: String
    let uploadURL: String
    let tarballURL, zipballURL: String
    let id: Int
    let nodeID, tagName, targetCommitish, name: String
    let body: String?
    let draft, prerelease: Bool
    let createdAt, publishedAt: String
    let author: Author
    let assets: [Asset]

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case assetsURL = "assets_url"
        case uploadURL = "upload_url"
        case tarballURL = "tarball_url"
        case zipballURL = "zipball_url"
        case id
        case nodeID = "node_id"
        case tagName = "tag_name"
        case targetCommitish = "target_commitish"
        case name, body, draft, prerelease
        case createdAt = "created_at"
        case publishedAt = "published_at"
        case author, assets
    }
}

extension ReleaseData {
    var converted: Release {
        return Release(tagName: self.tagName,
                       releaseDesciption: self.body,
                       publishedDate: self.publishedAt,
                       isDraft: self.draft,
                       isPreRelease: self.prerelease)
    }
}

// MARK: - Asset
struct Asset: Codable {
    let url: String
    let browserDownloadURL: String
    let id: Int
    let nodeID, name, label, state: String
    let contentType: String
    let size, downloadCount: Int
    let createdAt, updatedAt: Date
    let uploader: Author

    enum CodingKeys: String, CodingKey {
        case url
        case browserDownloadURL = "browser_download_url"
        case id
        case nodeID = "node_id"
        case name, label, state
        case contentType = "content_type"
        case size
        case downloadCount = "download_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case uploader
    }
}

// MARK: - Author
struct Author: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
