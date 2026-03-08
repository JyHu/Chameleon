//
//  ImagesView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/21.
//

import SwiftUI

/// 显示所有的图片
struct ImagesView: View {
    @EnvironmentObject private var resVM: ResourcesViewModel
    @State private var selectedImageIDs: Set<ImageInfoModel.ID> = []
    
    var body: some View {
        Table(resVM.imageInfos, selection: $selectedImageIDs) {
            TableColumn("name", value: \.name)
                .width(min: 200, max: 300)
            
            TableColumn("存储策略") {
                switch $0.strategy {
                case .imageAsset:
                    Image(sfname: .photoOnRectangleAngled)
                case .liberty:
                    Image(sfname: .folder)
                case .localized:
                    Image(sfname: .folder)
                }
            }
            .width(min: 30, max: 64)
            
            TableColumn("本地化") {
                switch $0.strategy {
                case .imageAsset:
                    Image(sfname: $0.assetsImages.isEmpty ? .xmark : .checkmark)
                case .localized:
                    Image(sfname: .checkmark)
                case .liberty:
                    Image(sfname: .xmark)
                }
            }
            .width(min: 30, max: 64)
        }
    }
}
