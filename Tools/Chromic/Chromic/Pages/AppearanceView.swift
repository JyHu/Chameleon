//
//  AppearanceView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    var body: some View {
        if let root = resVM.rootNode {
            makeTable(of: root)
        } else {
            VStack {
                Text("No project, please choose first")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private extension AppearanceView {
    @ViewBuilder
    func makeTable(of rootNode: AppearanceNode) -> some View {
        Table([rootNode], children: \.children, selection: $resVM.selectedNodeIDs) {
            TableColumn("Name") { node in
                TextField("", text: Binding(get: { node.name }, set: {
                    node.name = $0
                }))
            }
            .width(min: 100, max: 300)
            
            TableColumn("Code") { node in
                
            }
            .width(min: 64, max: 200)

            TableColumnForEach(resVM.appearanceFiles) { file in
                TableColumn(file.name) {
                    if let imageNode = $0 as? ImageSourceNode {
                        if let imageName = imageNode.imageMap[file.id] {
                            if let imageInfo = resVM.imageMap[imageName],
                               let imageURL = imageInfo.pickImage(),
                               let nsimage = NSImage(contentsOf: imageURL) {
                                
                                HStack {
                                    Image(nsImage: nsimage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 24)
                                    
                                    /// 显示image是否有本地化、有缺失
                                    
                                }
                            } else {
                                Text(imageName)
                            }
                        }
                    } else  if let node = $0 as? ColorSourceNode, let model = node.colorMap[file.id] {
                        HStack {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(model.color)
                                .frame(width: 24, height: 18)
                                .border(Color.white, width: 1)
                                .border(Color.clear, width: 1)
                                .border(Color.black, width: 1)
                            Text(model.hexString)
                                .fontDesign(.monospaced)
                        }
                    }
                }
                .width(min: 150)
            }
        }
    }
}
