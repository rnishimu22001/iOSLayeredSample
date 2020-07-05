//
//  UserDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

struct CollaboratorDisplayData: Identifiable {
   
    let id = UUID()
    
    let hasAdminBadge: Bool
    let icon: URL
    let name: String
    
    init(with collaborator: Collaborator) {
        hasAdminBadge = collaborator.isAdmin
        icon = collaborator.icon
        name = collaborator.name
    }
}

struct CollaboratorsDisplayData {
    let collaborators: [CollaboratorDisplayData]
    init(with collaborators: [Collaborator]) {
        self.collaborators = collaborators.map { CollaboratorDisplayData(with: $0) }
    }
}
