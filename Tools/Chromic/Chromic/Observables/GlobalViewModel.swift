//
//  GlobalViewModel.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

class GlobalViewModel: ObservableObject {
    @Published var hadOpen = false
    
    static let shared = GlobalViewModel()
    
    var resVMs: [ResourcesViewModel] = []
    
    func generateResVM() -> ResourcesViewModel {
        func generate() -> ResourcesViewModel {
            let vm = ResourcesViewModel()
            resVMs.append(vm)
            return vm
        }
        
        if hadOpen {
            return generate()
        }
        
        /// 获取一个之前打开的项目
        if let bookmark = UserDefaults.standard.string(forKey: UserDefaultsKeys.projectFolder),
           let url = try? URL.bookmarkURL(from: bookmark) {
            let vm = ResourcesViewModel(projectFolder: url)
            resVMs.append(vm)
            hadOpen = true
            return vm
        }
        
        return generate()
    }
    
    func checkHadOpen(at folder: URL) -> Bool {
        return resVMs.contains { $0.projectFolder == folder }
    }
}
