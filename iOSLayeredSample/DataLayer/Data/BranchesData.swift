//
//  BranchesData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let branches = try? newJSONDecoder().decode(Branches.self, from: jsonData)

import Foundation

// MARK: - Branch
struct BranchData: Codable {
    let name: String
    let commit: Commit
    let protected: Bool
    let protection: Protection
    let protectionURL: String

    enum CodingKeys: String, CodingKey {
        case name, commit, protected, protection
        case protectionURL = "protection_url"
    }
}

extension BranchData {
    var converted: Branch {
        return Branch(name: self.name, isProtected: self.protected)
    }
}

// MARK: - Commit
struct Commit: Codable {
    let sha: String
    let url: String
}

// MARK: - Protection
struct Protection: Codable {
    let enabled: Bool
    let requiredStatusChecks: RequiredStatusChecks

    enum CodingKeys: String, CodingKey {
        case enabled
        case requiredStatusChecks = "required_status_checks"
    }
}

// MARK: - RequiredStatusChecks
struct RequiredStatusChecks: Codable {
    let enforcementLevel: String
    let contexts: [String]

    enum CodingKeys: String, CodingKey {
        case enforcementLevel = "enforcement_level"
        case contexts
    }
}

typealias BranchesData = [BranchData]
