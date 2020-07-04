//
//  SwiftUIReleaseView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIReleaseView: View {
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Latest Release:")
                        .font(.subheadline)
                        .padding(Layout.margin)
                    Text("tag here")
                        .font(.body)
                        .padding(Layout.margin)
                    Text("status here")
                        .font(.body)
                        .padding(Layout.margin / 2)
                        .colorInvert()
                        .background(Color.gray)
                        .padding(Layout.margin / 2)
                    Spacer(minLength: 8)
                }
                HStack {
                    Text("Date:")
                        .font(.subheadline)
                        .padding(Layout.margin)
                    Text("Release date here")
                        .font(.subheadline)
                        .padding(Layout.margin)
                    Spacer(minLength: 8)
                    
                }
                HStack {
                    Text("description here")
                        .font(.body)
                        .padding(Layout.margin)
                    Spacer(minLength: 8)
                }
            }
        }
    }
}

struct SwiftUIReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIReleaseView()
    }
}
