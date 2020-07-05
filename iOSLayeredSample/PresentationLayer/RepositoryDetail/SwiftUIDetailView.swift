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
    
    private var contentsView: some View {
        VStack {
            if viewModel.profile != nil {
                SwiftUICommunityProfileView(profile: viewModel.profile!)
                SeparatorView()
            } else {
                EmptyView()
            }
            if viewModel.release != nil {
                SwiftUIReleaseView(release: viewModel.release!)
                SeparatorView()
            } else {
                EmptyView()
            }
            if viewModel.branch != nil {
                SwiftUIBranchView(branch: viewModel.branch!)
                SeparatorView()
            } else {
                EmptyView()
            }
            if viewModel.collaborators != nil {
                SwiftUICollaboratorsView(collaborators: viewModel.collaborators!)
                SeparatorView()
            } else {
                EmptyView()
            }
            if viewModel.pagingLoading != nil {
                AnyView(EmptyView())
            } else {
                EmptyView()
            }
        }
    }
    
    private var statusView: AnyView {
        switch viewModel.status {
        case .browsable:
            return AnyView(contentsView)
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
