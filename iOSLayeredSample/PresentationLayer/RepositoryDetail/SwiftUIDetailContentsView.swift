//
//  DetailContentsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUICommunityProfileView: View {
    
    let profile: CommunityProfileDisplayData
    
    var body: some View {
        VStack {
            HStack {
                Text("Last Update:").padding(Layout.margin)
                    .font(.subheadline)
                Text(profile.lastUpdate).padding(Layout.margin)
                    .font(.body)
                Spacer()
            }
            HStack {
                Text("License:")
                    .font(.subheadline)
                    .padding(Layout.margin)
                Text(profile.license)
                    .font(.body)
                    .padding(Layout.margin / 2)
                    .colorInvert()
                    .background(Color.gray)
                    .padding(Layout.margin / 2)
                Spacer()
            }
            HStack {
                Text(profile.repositoryDescription)
                    .font(.body)
                    .padding(Layout.margin)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: Layout.margin)
            }
        }
    }
}
