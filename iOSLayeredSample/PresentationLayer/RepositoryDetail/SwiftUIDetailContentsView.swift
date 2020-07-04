//
//  DetailContentsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIDetailContentsView: View {
    var body: some View {
        VStack {
            SwiftUICommunityProfileView()
        }
    }
}

struct SwiftUICommunityProfileView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Last Update:").padding(Layout.margin)
                    .font(.subheadline)
                Text("Date").padding(Layout.margin)
                    .font(.body)
                Spacer()
            }
            HStack {
                Text("License:")
                    .font(.subheadline)
                    .padding(Layout.margin)
                Text("Any")
                    .font(.body)
                    .padding(Layout.margin / 2)
                    .colorInvert()
                    .background(Color.gray)
                    .padding(Layout.margin / 2)
                Spacer()
            }
            HStack {
                Text("description here")
                    .font(.body)
                    .padding(Layout.margin)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: Layout.margin)
            }
        }
    }
}

struct DetailContentsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDetailContentsView()
    }
}
