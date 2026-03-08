//
//  ImageCodeView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

struct ImageCodeView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    var body: some View {
        VStack {
            if let urlItem = resVM.imageCodeFile {
                HStack {
                    Button {
                        NSWorkspace.shared.activateFileViewerSelecting([urlItem.url])
                    } label: {
                        Label(urlItem.relativePath, sfname: .link)
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(.borderless)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            
            TextEditor(text: $resVM.imageCodeModule)
        }
    }
}

extension ImageCodeView {
    struct Actions: View {
        @EnvironmentObject var resVM: ResourcesViewModel

        var body: some View {
            ImportView(allowedContentTypes: [.swiftSource, .objectiveCSource]) { urls in
                if let url = urls.first {
                    resVM.update(imageCodeFile: url)
                }
            } label: {
                if let url = resVM.imageCodeFile {
                    Text(url.relativePath)
                } else {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
