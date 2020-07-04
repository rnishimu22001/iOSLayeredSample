//
//  Collaborator.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

// API document here
// https://developer.github.com/v3/repos/collaborators/

// MARK: - Collaborator
struct CollaboratorData: Codable {
    
    let author: Author
    let total: Int
    
    // MARK: - Author
    struct Author: Codable {
        let login: String
        let id: Int
        let nodeID: String
        let avatarURL: URL
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
    
    // MARK: - Week
    struct Week: Codable {
        let w: String
        let a, d, c: Int
    }
}

extension CollaboratorData {
    var converted: Collaborator {
        return Collaborator(isAdmin: self.author.siteAdmin, icon: self.author.avatarURL, name: self.author.login)
    }
}

typealias CollaboratorsData = [CollaboratorData]
