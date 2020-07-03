//
//  SwiftUIReleaseView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIReleaseView: View {
    
    let layout = Layout()
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Latest Release:")
                        .font(.subheadline)
                        .padding(layout.margin)
                    Text("tag here")
                        .font(.body)
                        .padding(layout.margin)
                    Text("status here")
                        .font(.body)
                        .padding(layout.margin / 2)
                        .colorInvert()
                        .background(Color.gray)
                        .padding(layout.margin / 2)
                    Spacer(minLength: 8)
                }
                HStack {
                    Text("Date:")
                        .font(.subheadline)
                        .padding(layout.margin)
                    Text("Release date here")
                        .font(.subheadline)
                        .padding(layout.margin)
                    Spacer(minLength: 8)
                    
                }
                HStack {
                    Text("description here")
                        .font(.body)
                        .padding(layout.margin)
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
