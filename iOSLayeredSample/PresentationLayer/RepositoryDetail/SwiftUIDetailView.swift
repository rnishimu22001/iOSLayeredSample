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
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    init(reposiotryName: String) {
        self.init(viewModel: DetailViewModel(repositoryFullName: reposiotryName))
    }
    
    var body: some View {
        Text("hello")
    }
}

struct SwiftUIDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
