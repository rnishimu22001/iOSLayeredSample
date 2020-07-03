//
//  SwiftUIBranchView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIBranchView: View {
    
    let layout = Layout()
    
    var body: some View {
        HStack {
            Text("Branch Name:")
                .padding(layout.margin)
                .font(.subheadline)
            Text("Branch name here")
                .padding(layout.margin)
                .font(.body)
            Text("protected")
                .font(.body)
                .colorInvert()
                .padding(layout.margin / 2)
                .background(Color.blue)
                .padding(layout.margin / 2)
            Spacer(minLength: layout.margin)
        }
    }
}
