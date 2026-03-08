//
//  ImageNodeView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

struct ImageNodeView: View {
    @EnvironmentObject private var resVM: ResourcesViewModel
    @ObservedObject var imageNode: ImageSourceNode
    
    var body: some View {
        GroupBox(imageNode.path) {
            HStack {
                Text("Image Name")
                TextField("", text: $imageNode.name)
            }
            
            ForEach(resVM.appearanceFiles) { file in
                GroupBox(file.name) {
                    if let imageName = imageNode.imageMap[file.id],
                        let imageInfo = resVM.imageMap[imageName] {
                        switch imageInfo.strategy {
                        case .imageAsset:
                            makeImageAssetView(for: imageInfo.baseAsset, of: imageInfo)
                            
                            ForEach(imageInfo.assetsImages) { asset in
                                makeImageAssetView(for: asset, of: imageInfo)
                            }
                        case .localized:
                            if let localizedInfo = imageInfo.localizedInfo {
                                makeLocalizedImageView(for: localizedInfo, of: imageInfo)
                            }
                        case .liberty:
                            makeImage(of: imageInfo.location.appendingPathComponent(imageInfo.imageName))
                        }
                    } else {
                        makeNoImageView()
                    }
                }
            }
        }
    }
}

private extension ImageNodeView {
    @ViewBuilder
    func makeLocalizedImageView(for localizedInfo: LocalizedImageModel, of imageInfo: ImageInfoModel) -> some View {
        HStack {
            ForEach(localizedInfo.languages) { lang in
                VStack {
                    HStack {
                        ForEach(ImageScale.allCases) { scale in
                            if let img = lang.scales.first(where: { $0.scale == scale }) {
                                let url = imageInfo.location.appendingPathComponent(lang.language + ".lproj" + "/" + img.name)
                                
                                VStack {
                                    makeImage(of: url)
                                        .frame(width: 85, height: 85)
                                    Text(img.scale.rawValue)
                                }
                            } else {
                                makeNoImageView()
                            }
                        }
                    }
                    
                    Divider()
                    
                    Text(lang.language)
                }
            }
        }
    }
    
    @ViewBuilder
    func makeImageAssetView(for asset: ImageAssetModel, of imageInfo: ImageInfoModel) -> some View {
        VStack {
            HStack {
                makeImageView(for: asset.x1, of: imageInfo)
                makeImageView(for: asset.x2, of: imageInfo)
                makeImageView(for: asset.x3, of: imageInfo)
            }
            
            if let language = asset.local {
                Text(language)
            }
        }
    }
    
    @ViewBuilder
    func makeImageView(for langAsset: ImageModel?, of imageInfo: ImageInfoModel) -> some View {
        if let langAsset {
            let url = imageInfo.location.appendingPathComponent(langAsset.fileName)
            
            VStack {
                makeImage(of: url)
                    .frame(width: 85, height: 85)
                Text(langAsset.scale.rawValue)
            }
        } else {
            makeNoImageView()
        }
    }
}

private extension View {
    @ViewBuilder
    func makeImage(of url: URL) -> some View {
        if FileManager.default.fileExists(atPath: url.filePath),
           let nsimage = NSImage(contentsOf: url) {
            Image(nsImage: nsimage)
        } else {
            makeNoImageView()
        }
    }
    
    @ViewBuilder
    func makeNoImageView() -> some View {
        HStack {
            Text("No Image")
                .foregroundStyle(.secondary)
        }
    }
}
