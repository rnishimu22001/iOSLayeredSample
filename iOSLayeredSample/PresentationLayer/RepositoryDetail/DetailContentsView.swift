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
    
    let layout = Layout()
    
    var body: some View {
        VStack {
            HStack {
                Text("Last Update:").padding(layout.margin)
                Text("Date").padding(layout.margin)
                Spacer()
            }
            HStack {
                Text("License:")
                    .padding(layout.margin)
                Text("Any")
                    .padding(layout.margin / 2)
                    .colorInvert()
                    .background(Color.gray)
                    .padding(layout.margin / 2)
                Spacer()
            }
            HStack {
                Text("description here")
                    .padding(layout.margin)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: layout.margin)
            }
        }
    }
}

struct DetailContentsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDetailContentsView()
    }
}
