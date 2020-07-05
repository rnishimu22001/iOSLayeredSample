//
//  DetailContentsView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/03.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct SwiftUIDetailContentsView: View {
    
    var contents: [Any]
    
    var body: some View {
        ForEach(contents.indices) { index in
            self.contentView(with: self.contents[index])
            SeparatorView()
        }
    }
    
    private func contentView(with content: Any) -> AnyView {
        switch content {
        case let profile as CommunityProfileDisplayData:
            return AnyView(SwiftUICommunityProfileView())
        case let release as ReleaseDisplayData:
            return AnyView(SwiftUIReleaseView())
        case let branch as BranchDisplayData:
            return AnyView(SwiftUIBranchView())
        case let collaborators as CollaboratorsDisplayData:
            return AnyView(SwiftUICollaboratorsView())
        case let loading as LoadingDisplayData:
            return AnyView(EmptyView())
        default:
            assertionFailure("未設定のデータ型です")
            return AnyView(EmptyView())
        }
    }
}

struct SwiftUICommunityProfileView: View {
    
    let profile: CommunityProfileDisplayData
    
    var body: some View {
        VStack {
            HStack {
                Text("Last Update:").padding(Layout.margin)
                    .font(.subheadline)
                Text(profile.lastUpdate).padding(Layout.margin)
                    .font(.body)
                Spacer()
            }
            HStack {
                Text("License:")
                    .font(.subheadline)
                    .padding(Layout.margin)
                Text(profile.license)
                    .font(.body)
                    .padding(Layout.margin / 2)
                    .colorInvert()
                    .background(Color.gray)
                    .padding(Layout.margin / 2)
                Spacer()
            }
            HStack {
                Text(profile.repositoryDescription)
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
        SwiftUIDetailContentsView(contents: [])
    }
}
