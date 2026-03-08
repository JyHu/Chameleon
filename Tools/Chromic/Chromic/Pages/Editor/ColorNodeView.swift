//
//  ColorNodeView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

struct ColorNodeView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    @ObservedObject var colorNode: ColorSourceNode
    
    var body: some View {
        GroupBox(colorNode.path) {
            Grid {
                ForEach(resVM.appearanceFiles) { file in
                    if let colorModel = colorNode.colorMap[file.id] {
                        GridRow {
                            Text(file.name)
                            
                            ColorPicker("", selection: Binding(get: {
                                return colorModel.color
                            }, set: { color in
                                colorModel.color = color
                            }))
                            
                            HStack {
                                TextField("", text: Binding(get: {
                                    colorModel.hexString
                                }, set: { hexString in
                                    colorModel.hexString = hexString
                                }), prompt: Text("Color Hex"))
                                .frame(minWidth: 120)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}
