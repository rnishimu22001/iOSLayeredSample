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
    var collaborators: [CollaboratorDisplayData] = []
    
    var body: some View {
        VStack {
            Text("Collaborators")
            List(collaborators) { collaborator in
                HStack {
                    Image(systemName: "photo")
                    Text("Collaborator's name here")
                    Spacer(minLength: self.layout.margin)
                }
            }
        }
    }
}

