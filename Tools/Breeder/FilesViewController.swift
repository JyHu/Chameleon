//
//  FilesViewController.swift
//  Breeder
//
//  Created by Jo on 2023/4/7.
//

import Cocoa
import SwiftExtensions
import Combine

private extension NSUserInterfaceItemIdentifier {
    static let index = NSUserInterfaceItemIdentifier("com.auu.chameleon.files.index")
    static let name = NSUserInterfaceItemIdentifier("com.auu.chameleon.files.name")
    static let path = NSUserInterfaceItemIdentifier("com.auu.chameleon.files.path")
    static let delete = NSUserInterfaceItemIdentifier("com.auu.chameleon.files.delete")
}

class FilesViewController: NSViewController {

    private var tableView = NSTableView(frame: NSMakeRect(0, 0, 100, 100))
    private var subscription: AnyCancellable?
    
    override func loadView() {
        view = NSScrollView(documentView: tableView, isHorizontal: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.focusRingType = .none
        tableView.allowsColumnResizing = true
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.addTableColumn(identifier: .index, title: "Index", width: 36)
        tableView.addTableColumn(identifier: .name, title: "Name", minWidth: 48, maxWidth: 120)
        tableView.addTableColumn(identifier: .path, title: "Path", minWidth: 150)
        tableView.addTableColumn(identifier: .delete, title: "", width: 64)
        
        subscription = DataCenter.shared.$files.sink { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

extension FilesViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return DataCenter.shared.files.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let identifier = tableColumn?.identifier else { return nil }
        if identifier == .index {
            return "\(row)"
        }
        
        let fileInfo = DataCenter.shared.files[row]
        
        if identifier == .name {
            return fileInfo.name
        }
        
        if identifier == .path {
            return fileInfo.url?.getPath()
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        guard let identifier = tableColumn?.identifier else { return nil }
        if identifier == .index {
            return NSTextFieldCell()
        } else if identifier == .path {
            return NSTextFieldCell()
        } else if identifier == .delete {
            let cell = NSButtonCell(textCell: "Delete")
            cell.bezelStyle = .rounded
            cell.target = self
            cell.action = #selector(deleteFilesAction)
            return cell
        }
        
        return nil
    }
    
    func controlTextDidChange(_ obj: Notification) {
        
    }
}

private extension FilesViewController {
    @objc func deleteFilesAction() {
        
    }
}
