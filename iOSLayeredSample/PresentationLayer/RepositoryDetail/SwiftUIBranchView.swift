//
//  SwiftUIBranchView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIBranchView: View {
    
    let branch: BranchDisplayData
    
    var body: some View {
        HStack {
            Text("Branch Name:")
                .padding(Layout.margin)
                .font(.subheadline)
            Text(branch.name)
                .padding(Layout.margin)
                .font(.body)
            if !branch.shouldHideProtected {
                Text("protected")
                    .font(.body)
                    .colorInvert()
                    .padding(Layout.margin / 2)
                    .background(Color.blue)
                    .padding(Layout.margin / 2)
            }
            Spacer(minLength: Layout.margin)
        }
    }
}
