//
//  SwiftUICollaboratorsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/04.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUICollaboratorsView: View {
    
    let collaborators: CollaboratorsDisplayData
   
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
                ForEach(collaborators.collaborators) { collaborator in
                    if !collaborator.hasAdminBadge {
                        HStack {
                            Image(systemName: "photo")
                                .padding(Layout.margin)
                            Text(collaborator.name)
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

