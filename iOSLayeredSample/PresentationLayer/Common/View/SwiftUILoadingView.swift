//
//  SwiftUILoadingView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/05.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI
import UIKit

struct SwiftUILoadingView: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView

    func makeUIView(context: UIViewRepresentableContext<SwiftUILoadingView>) -> Self.UIViewType {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
