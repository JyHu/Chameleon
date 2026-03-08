//
//  ImportView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI
import UniformTypeIdentifiers

struct ImportView<L: View>: View {
    @State private var showChooicePanel = false
    
    @ViewBuilder var label: () -> L
    
    let allowedContentTypes: [UTType]
    let allowsMultipleSelection: Bool
    let completion: ([URL]) -> Void
    
    init(
        allowedContentTypes: [UTType],
        allowsMultipleSelection: Bool = false,
        completion: @escaping ([URL]) -> Void,
        @ViewBuilder label: @escaping () -> L
    ) {
        self.allowedContentTypes = allowedContentTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.completion = completion
        self.label = label
    }
    
    var body: some View {
        Button {
            showChooicePanel = true
        } label: {
            Image(sfname: .plus)
        }
        .buttonStyle(.borderless)
        .fileImporter(
            isPresented: $showChooicePanel,
            allowedContentTypes: allowedContentTypes,
            allowsMultipleSelection: allowsMultipleSelection) { result in
                if let urls = try? result.get(), urls.count > 0 {
                    completion(urls)
                }
            }
    }
}

extension ImportView where L == Image {
    init(
        allowedContentTypes: [UTType],
        allowsMultipleSelection: Bool = false,
        completion: @escaping ([URL]) -> Void
    ) {
        self.allowedContentTypes = allowedContentTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.completion = completion
        self.label = {
            Image(sfname: .plus)
        }
    }
}
