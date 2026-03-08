//
//  ImageLocationsView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

struct ImageLocationsView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    @State private var selectedFolders: Set<URLItem.ID> = []
    
    var body: some View {
        VStack {
            Table(resVM.imageFolders, selection: $selectedFolders) {
                TableColumn("", value: \.relativePath)
            }
            .tableColumnHeaders(.hidden)
        }
    }
}

extension ImageLocationsView {
    struct Actions: View {
        @EnvironmentObject var resVM: ResourcesViewModel

        var body: some View {
            ImportView(allowedContentTypes: [.folder]) { urls in
                if let url = urls.first {
                    resVM.append(imageFolder: url)
                }
            }
        }
    }
}
