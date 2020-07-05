//
//  SwiftUIReleaseView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIReleaseView: View {
    
    let release: ReleaseDisplayData
    
    var body: some View {
        VStack {
            HStack {
                Text("Latest Release:")
                    .font(.headline)
                    .padding(Layout.margin)
                Text(release.tagName)
                    .font(.headline)
                    .padding(Layout.margin)
                Text(release.status.rawValue)
                    .font(.body)
                    .padding(Layout.margin / 2)
                    .colorInvert()
                    .background(Color(release.status.color))
                    .padding(Layout.margin / 2)
                Spacer(minLength: 8)
            }
            HStack {
                Text("Date:")
                    .font(.subheadline)
                    .padding(Layout.margin)
                Text(release.publishedDate)
                    .font(.subheadline)
                    .padding(Layout.margin)
                Spacer(minLength: 8)
                
            }
            HStack {
                Text(release.releaseDesciption)
                    .font(.body)
                    .padding(Layout.margin)
                Spacer(minLength: 8)
            }
        }
    }
}
