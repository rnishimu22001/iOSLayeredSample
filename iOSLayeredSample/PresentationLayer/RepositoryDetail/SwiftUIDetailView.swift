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
    
    private let viewModel: DetailViewModelProtocol
    let repositoryName: String
    
    init(repositoryName: String) {
        self.repositoryName = repositoryName
        self.viewModel = DetailViewModel(repositoryFullName: repositoryName)
    }
    
    var body: some View {
        ScrollView {
            SwiftUIDetailContentsView()
            SwiftUIReleaseView()
            SwiftUIBranchView()
            SwiftUICollaboratorsView()
            Spacer()
        }
        .navigationBarTitle(repositoryName)
    }
}

struct SwiftUIDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(repositoryName: "test")
    }
}
