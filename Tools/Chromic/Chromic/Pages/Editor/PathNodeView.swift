//
//  PathNodeView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

struct PathNodeView: View {
    @EnvironmentObject private var resVM: ResourcesViewModel
    @ObservedObject private var node: AppearanceNode
    
    @State var name: String
    @State private var showChangeAlert: Bool = false
    
    init(node: AppearanceNode) {
        self.node = node
        self.name = node.name
    }
    
    var body: some View {
        GroupBox(node.path) {
            if node.isEditble {
                Grid {
                    GridRow {
                        Text("Node Name")
                        TextField("", text: $node.name, prompt: Text("Node Name"))
                    }
                    
                    GridRow {
                        Text("Node Comment")
                        TextField("", text: $node.comment, prompt: Text("Node Comment"))
                    }
                }
                
                HStack {
                    Button("Save") {
                        showChangeAlert = true
                    }
                    
                    Button("Reset") {
                        
                    }
                }
            } else {
                HStack {
                    Text("Node name")
                        .foregroundStyle(.secondary)
                    
                    Text(node.name)
                    
                    Spacer()
                }
            }
        }
        .alert("Warning", isPresented: $showChangeAlert) {
            Button("Confirmed") {
                node.name = name
            }
            
            Button("Cancel") { }
        } message: {
            Text("Are you sure you want to change the node name? This action cannot be undone.")
        }
    }
}
