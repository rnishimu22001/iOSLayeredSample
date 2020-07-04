//
//  SwiftUICollaboratorsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/04.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUICollaboratorsView: View {
   
    let layout = Layout()
    var collaborators: [CollaboratorDisplayData] = [
        CollaboratorDisplayData(with: Collaborator(isAdmin: false, icon: URL(string: "https://avatars1.githubusercontent.com/u/25366111?s=400&v=4")!, name: "rnishimu22001"))
    ]
    
    struct TitleView: View {
        let layout = Layout()
        var body: some View {
            HStack {
                Text("Collaborators")
                    .padding(layout.margin)
                Spacer(minLength: layout.margin)
            }
        }
    }
    
    var body: some View {
        VStack {
            TitleView()
            VStack {
                ForEach(collaborators) { collaborator in
                    HStack {
                        Image(systemName: "photo")
                            .padding(self.layout.margin)
                        Text("Collaborator's name here")
                        Spacer(minLength: self.layout.margin)
                    }
                }
            }
        }
    }
}

