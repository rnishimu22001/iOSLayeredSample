//
//  SwiftUIDetailView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/02.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI
import UIKit

struct DetailView: View {
    
    @ObservedObject private var viewModel: DetailViewModel
    let repositoryName: String
    
    init(repositoryName: String) {
        self.repositoryName = repositoryName
        self.viewModel = DetailViewModel(repositoryFullName: repositoryName)
        viewModel.reload()
    }
    
    @ViewBuilder
    var body: some View {
        ScrollView {
            statusView
        }
        .navigationBarTitle(repositoryName)
    }
    
    private var statusView: AnyView {
        switch viewModel.status {
        case .browsable:
            return AnyView(SwiftUIDetailContentsView(contents: viewModel.contents))
        case .error:
            return AnyView(Text("error"))
        case .initalized, .loading:
            return AnyView(Text("loading"))
        }
    }
}

struct SwiftUIDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(repositoryName: "test")
    }
}
