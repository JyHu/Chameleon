//
//  AppearanceFilesView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

struct AppearanceFilesView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    @State private var selectedFileID: AppearanceFile.ID?
    @State private var showImport = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Image Root Node")
                    .foregroundStyle(.secondary)
                
                TextField("", text: $resVM.imageRootName)
                    .frame(width: 100)
                
                Text("Color Root Node")
                    .foregroundStyle(.secondary)
                
                TextField("", text: $resVM.colorRootName)
                    .frame(width: 100)
                
                Button("Process") {
                    resVM.reprocessAppearanceFiles()
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: 24)
            
            Table(resVM.appearanceFiles, selection: $selectedFileID) {
                TableColumn("Name") {
                    _NameFiled(file: $0)
                }
                .width(200)
                
                TableColumn("Path", value: \.fileURL.relativePath)
            }
            .tableColumnHeaders(.hidden)
            .contextMenu {
                let selectedFile = resVM.appearanceFiles.first(where: { $0.id == selectedFileID })
                
                Button {
                    NSWorkspace.shared.activateFileViewerSelecting([selectedFile!.fileURL.url])
                } label: {
                    HStack {
                        Image(sfname: .folder)
                        Text("Open in Finder")
                    }
                }
                .disabled(selectedFile == nil)
                
                Button {
                    showImport =  true
                } label: {
                    HStack {
                        Image(sfname: .plus)
                        Text("Add File")
                    }
                }
                
                Button(role: .destructive) {
                    resVM.removeAppearanceFile(with: selectedFileID)
                } label: {
                    HStack {
                        Image(sfname: .xmark)
                        Text("Remove")
                    }
                }
                .disabled(selectedFile == nil)
            }
            .fileImporter(isPresented: $showImport, allowedContentTypes: [.url]) { result in
                guard let url = try? result.get() else { return }
                resVM.append(appearanceFile: url)
            }
        }
    }
}

private struct _NameFiled: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    @ObservedObject var file: AppearanceFile
    
    var body: some View {
        TextField("", text: $file.name)
            .onChange(of: file.name) { oldValue, newValue in
                resVM.synchronize()
            }
    }
}

extension AppearanceFilesView {
    struct Actions: View {
        @EnvironmentObject var resVM: ResourcesViewModel

        var body: some View {
            ImportView(allowedContentTypes: [.json]) { urls in
                if let url = urls.first {
                    resVM.append(appearanceFile: url)
                }
            }
        }
    }
}
