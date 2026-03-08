//
//  EditorView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

struct EditorView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    var body: some View {
        if resVM.selectedNodeIDs.isEmpty {
            VStack {
                Text("No file selected")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(resVM.selectedNodeIDs.sorted(by: { $0 < $1}), id: \.self) { id in
                        if let node = resVM.rootNode?.getNodeWithID(id) {
                            if let node = node as? ImageSourceNode {
                                ImageNodeView(imageNode: node)
                            } else if let node = node as? ColorSourceNode {
                                ColorNodeView(colorNode: node)
                            } else {
                                PathNodeView(node: node)
                            }
                        }
                    }
                }
                .padding(.all, 8)
            }
        }
    }
}
