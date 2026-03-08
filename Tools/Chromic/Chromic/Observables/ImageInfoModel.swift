//
//  ImageInfoModel.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/19.
//

import SwiftUI

enum ImageStatus: String, Identifiable {
    case lackOfLanguages
    case lackOfScales
    
    var id: String { rawValue }
}

enum ImageStrategy: String {
    /// 存在image asset里
    case imageAsset
    /// 存在本地化的语言目录中
    case localized
    /// 自由存储在目录中
    case liberty
}

enum ImageScale: String, Identifiable, CaseIterable {
    case x1 = "1x"
    case x2 = "2x"
    case x3 = "3x"
    
    var id: String { rawValue }
}

class ScaledImage {
    var scale: ImageScale
    var name: String
    
    init(scale: ImageScale, name: String) {
        self.scale = scale
        self.name = name
    }
}

class ImageModel {
    /// aaa@2x.png
    var fileName: String = ""
    /// 图片本地化的语言名称，en zh-Hans 等
    var local: String?
    /// 图片的分辨率
    var scale: ImageScale = .x1
    /// 图片的idiom，通常是 universal
    var idiom: String = "universal"
    
    init?(dict: [String: Any]) {
        guard let fileName = dict["filename"] as? String,
        let rawValue = dict["scale"] as? String,
        let scale = ImageScale(rawValue: rawValue) else {
            return nil
        }
        
        self.fileName = fileName
        self.scale = scale
        self.local = dict["locale"] as? String
        
        if let idiom = dict["idiom"] as? String {
            self.idiom = idiom
        }
    }
}

class LocalizedImageModel: ObservableObject, CustomStringConvertible {
    class Languages: Identifiable {
        let language: String
        var scales: [ScaledImage] = []
        
        var id: String { language }
        
        init(language: String) {
            self.language = language
        }
    }

    var imageName: String
    var languages: [Languages] = []
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var description: String {
        return languages.map { lang in
            lang.language + ": (" + lang.scales.map { $0.scale.rawValue }.joined(separator: ", ") + ")"
        }.joined(separator: ", ")
    }
}

class ImageAssetModel: Identifiable {
    var local: String?
    
    var x1: ImageModel?
    var x2: ImageModel?
    var x3: ImageModel?
    
    let id = UUID()
    
    func update(_ image: ImageModel) {
        switch image.scale {
        case .x1: x1 = image
        case .x2: x2 = image
        case .x3: x3 = image
        }
    }
    
    func pick() -> ImageModel? {
        return x1 ?? x2 ?? x3
    }
}

class ImageInfoModel: ObservableObject, Identifiable {
    let id = UUID()
    
    /// 图片所在的目录
    /// 如果是image asset，则是asset的目录
    /// 如果是本地化的图片，则是语言目录所在的目录
    /// 如果是单张的图片，则是这张图片所在的目录
    @Published var location: URL
    
    /// 图片的名称，在代码中使用的名称
    /// 如果是 imageAsset 方式的话，那么就是 xxx.imageasset 里的xxx
    /// 如果是 localized 方式的话，那么就是 xxx@1x.png 里的xxx
    /// 如果是 liberty 方式的话，那么就是 xxx.png 里的xxx
    @Published var name: String
    
    /// 图片的存储策略
    @Published var strategy: ImageStrategy
    
    ///
    /// 如果是 imageAsset 方式的话，那么需要使用的是
    /// - baseAsset 非本地化的图片资源
    /// - assetsImages 本地化的图片资源
    ///
    /// 如果是 localized 方式的话，表示自由存储在文件导航目录内的本地化的图片，
    /// 需要使用到：
    /// - localizedLanguages 本地化支持的语言
    /// - imageName 图片的名称
    /// 因为此种图片的缓存方式，图片名称必须都得是相同的，只是存放在不同的语言目录下
    ///
    /// 如果是 liberty 方式的话，表示自由存储在文件导航目录内的单张图片，
    /// 那么只需要使用
    /// - imageName 图片的名称
    ///
    
    /// 本地化的图片资源，存放在不同的语言目录下
    /// [en, zh-Hans, zh-Hant]
    @Published var localizedInfo: LocalizedImageModel?
    /// 没有多分辨率和本地化的单张图片
    @Published var imageName: String = ""
    
    @Published var baseAsset = ImageAssetModel()
    @Published var assetsImages: [ImageAssetModel] = []
    
    init(location url: URL, name: String, strategy: ImageStrategy) {
        self.location = url
        self.name = name
        self.strategy = strategy
    }
    
    init(imageURL url: URL) {
        self.strategy = .liberty
        self.location = url.deletingLastPathComponent()
        (self.name, _) = url.lastPathComponent.parseImageName()
    }
    
    init(imageName: String, infoModel: LocalizedImageModel, location: URL) {
        self.name = imageName
        self.localizedInfo = infoModel
        self.location = location
        self.strategy = .localized
    }
    
    init?(imageAsset url: URL) {
        let contentsFile = url.appendingPathComponent("Contents.json")

        guard FileManager.default.fileExists(atPath: contentsFile.filePath) else {
            return nil
        }
        
        self.strategy = .imageAsset
        self.location = url
        self.name = url.deletingPathExtension().lastPathComponent

        do {
            let data = try Data(contentsOf: contentsFile)
            
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            
            guard let images = json["images"] as? [[String: Any]] else {
                return nil
            }
            
            for dictInfo in images {
                guard let model = ImageModel(dict: dictInfo) else {
                    continue
                }

                let imageURL = url.appendingPathComponent(model.fileName)
                
                guard FileManager.default.fileExists(atPath: imageURL.filePath) else {
                    print("Image file does not exist: \(imageURL.filePath)")
                    continue
                }
                
                if model.local == nil {
                    baseAsset.update(model)
                } else {
                    if let asset = assetsImages.first(where: { $0.local == model.local }) {
                        asset.update(model)
                    } else {
                        let newAsset = ImageAssetModel()
                        newAsset.local = model.local
                        newAsset.update(model)
                        assetsImages.append(newAsset)
                    }
                }
            }
        } catch {
            print("Error reading image asset contents: \(error)")
        }
    }
    
    func pickImage() -> URL? {
        switch strategy {
        case .imageAsset:
            if let model = baseAsset.pick() {
                return location.appendingPathComponent(model.fileName)
            }
            
            for asset in assetsImages {
                if let model = asset.pick() {
                    return location.appendingPathComponent(model.fileName)
                }
            }
            
            return nil
        case .localized:
            if let languages = localizedInfo?.languages.first {
                if let scale = languages.scales.last {
                    return location.appendingPathComponent(languages.language + ".lproj" + "/" + scale.name)
                } else {
                    return location.appendingPathComponent(languages.language + ".lproj" + "/" + name + ".png")
                }
            }
            
            return nil
        case .liberty:
            return location.appendingPathComponent(imageName)
        }
    }
}

extension ImageInfoModel {
    ///
    /// - folder name
    ///     - en.lproj
    ///         - imagename@1x.png
    ///         - imagename@2x.png
    ///         - imagename@3x.png
    ///         - imagename2@1x.png
    ///         - imagename2@2x.png
    ///         - imagename2@3x.png
    ///     - zh-hans.lproj
    ///         - imagename@1x.png
    ///         - imagename@2x.png
    ///         - imagename@3x.png
    ///         - imagename2@1x.png
    ///         - imagename2@2x.png
    ///         - imagename2@3x.png
    ///     - zh-hant.lproj
    ///         - imagename@1x.png
    ///         - imagename@2x.png
    ///         - imagename@3x.png
    ///         - imagename2@1x.png
    ///         - imagename2@2x.png
    ///         - imagename2@3x.png
    ///
    ///  - imagename
    ///     - en
    ///         - 1x 2x 3x
    ///     - zh-Hans
    ///         - 1x 2x 3x
    ///     - zh-Hant
    ///         - 1x 2x 3x
    ///  - imagenam2
    ///     - en
    ///         - 1x 2x 3x
    ///     - zh-Hans
    ///         - 1x 2x 3x
    ///     - zh-Hant
    ///         - 1x 2x 3x
    ///
    static func searchImages(of languageFolds: [URL], in folder: URL) -> [String: ImageInfoModel] {
        /// [图片名称: [语言: [分辨率1， 分辨率2， 分辨率3]]]
        var images: [String: LocalizedImageModel] = [:]
        
        func getImageModel(of imageName: String) -> LocalizedImageModel {
            if let model = images[imageName] {
                return model
            }
            
            let model = LocalizedImageModel(imageName: imageName)
            images[imageName] = model
            return model
        }
        
        for languageFold in languageFolds {
            let language = languageFold.deletingPathExtension().lastPathComponent
            
            guard let files = try? FileManager.default.contentsOfDirectory(atPath: languageFold.filePath) else {
                continue
            }
            
            for file in files {
                if file.hasPrefix(".") { continue }
                
                let (imageName, scale) = file.parseImageName()
                
                let imageModel = getImageModel(of: imageName)
                
                if let langModel = imageModel.languages.first(where: { $0.language == language }) {
                    if let scale {
                        langModel.scales.append(ScaledImage(scale: scale, name: file))
                    }
                } else {
                    let langModel = LocalizedImageModel.Languages(language: language)
                    imageModel.languages.append(langModel)
                    
                    if let scale {
                        langModel.scales.append(ScaledImage(scale: scale, name: file))
                    }
                }
            }
        }
        
        return images.mapValues { ImageInfoModel(imageName: $0.imageName, infoModel: $0, location: folder) }
    }
}

private extension String {
    func parseImageName() -> (name: String, scale: ImageScale?) {
        if let index = lastIndex(of: ".") {
            return String(self[..<index]).parseImageName()
        }
        
        if let index = lastIndex(of: "@") {
            let name = String(self[..<index])
            let scaleString = String(self[index...].dropFirst())
            
            return (name: name, scale: ImageScale(rawValue: scaleString))
        } else {
            return (name: self, scale: nil)
        }
    }
}


//{
//  "images" : [
//    {
//      "filename" : "{ }hover@1x.png",
//      "idiom" : "universal",
//      "scale" : "1x"
//    },
//    {
//      "filename" : "{ }hover@2x.png",
//      "idiom" : "universal",
//      "scale" : "2x"
//    },
//    {
//      "filename" : "{ }hover@3x.png",
//      "idiom" : "universal",
//      "scale" : "3x"
//    }
//  ],
//  "info" : {
//    "author" : "xcode",
//    "version" : 1
//  }
//}
//
//
//{
//  "images" : [
//    {
//      "filename" : "删除.png",
//      "idiom" : "universal",
//      "scale" : "1x"
//    },
//    {
//      "filename" : "删除@2x.png",
//      "idiom" : "universal",
//      "scale" : "2x"
//    },
//    {
//      "filename" : "删除@3x.png",
//      "idiom" : "universal",
//      "scale" : "3x"
//    },
//    {
//      "filename" : "设置.png",
//      "idiom" : "universal",
//      "locale" : "en",
//      "scale" : "1x"
//    },
//    {
//      "filename" : "设置@2x.png",
//      "idiom" : "universal",
//      "locale" : "en",
//      "scale" : "2x"
//    },
//    {
//      "filename" : "设置@3x.png",
//      "idiom" : "universal",
//      "locale" : "en",
//      "scale" : "3x"
//    },
//    {
//      "filename" : "{ }hover@1x.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hant",
//      "scale" : "1x"
//    },
//    {
//      "filename" : "{ }hover@2x.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hant",
//      "scale" : "2x"
//    },
//    {
//      "filename" : "{ }hover@3x.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hant",
//      "scale" : "3x"
//    },
//    {
//      "filename" : "扩展.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hans",
//      "scale" : "1x"
//    },
//    {
//      "filename" : "扩展@2x.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hans",
//      "scale" : "2x"
//    },
//    {
//      "filename" : "扩展@3x.png",
//      "idiom" : "universal",
//      "locale" : "zh-Hans",
//      "scale" : "3x"
//    }
//  ],
//  "info" : {
//    "author" : "xcode",
//    "version" : 1
//  },
//  "properties" : {
//    "localizable" : true
//  }
//}
