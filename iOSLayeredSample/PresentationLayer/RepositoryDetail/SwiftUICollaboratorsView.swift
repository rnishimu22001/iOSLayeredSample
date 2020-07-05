//
//  SwiftUICollaboratorsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/04.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUICollaboratorsView: View {
   
    var collaborators: [CollaboratorDisplayData] = [
        CollaboratorDisplayData(with: Collaborator(isAdmin: false, icon: URL(string: "https://avatars1.githubusercontent.com/u/25366111?s=400&v=4")!, name: "rnishimu22001")),
        CollaboratorDisplayData(with: Collaborator(isAdmin: true, icon: URL(string: "https://avatars1.githubusercontent.com/u/25366111?s=400&v=4")!, name: "rnishimu22001"))
    ]
    
    struct TitleView: View {
        var body: some View {
            HStack {
                Text("Collaborators")
                    .font(.headline)
                    .padding(Layout.margin)
                Spacer(minLength: Layout.margin)
            }
        }
    }
    
    var body: some View {
        VStack {
            TitleView()
            VStack {
                ForEach(collaborators) { collaborator in
                    if !collaborator.hasAdminBadge {
                        HStack {
                            Image(systemName: "photo")
                                .padding(Layout.margin)
                            Text("Collaborator's name here")
                            Spacer(minLength: Layout.margin)
                        }
                    } else {
                        Text("is Admin")
                    }
                }
            }
        }
    }
}

