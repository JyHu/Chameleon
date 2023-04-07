//
//  MainWindowController.swift
//  Breeder
//
//  Created by Jo on 2023/4/7.
//

import Cocoa
import SFSymbols
import SwiftExtensions

private extension NSToolbar.Identifier {
    static let mainToolbar = NSToolbar.Identifier("com.auu.chameleon.toolbar")
}

private extension NSToolbarItem.Identifier {
    static let newItem = NSToolbarItem.Identifier("com.auu.chameleon.new")
    static let expandGroup = NSToolbarItem.Identifier("com.auu.chameleon.expand")
    static let filesGroup = NSToolbarItem.Identifier("com.auu.chameleon.files")
}

class MainWindowController: NSWindowController {
    init() {
        super.init(window: MainWindow())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainWindow: NSWindow, NSToolbarDelegate {
    
    private var mainSplit = NSSplitViewController()
    private var fileSplit = NSSplitViewController()
    
    private var filesPage = FilesViewController()
    private var infosPage = InfosViewController()
    private var detailPage = DetailViewController()
    
    init() {
        let styleMask: NSWindow.StyleMask = [ .closable, .titled, .resizable, .miniaturizable ]
        super.init(contentRect: NSMakeRect(0, 0, 720, 540), styleMask: styleMask, backing: .buffered, defer: true)
        
        fileSplit.isVertical = false
        fileSplit.add(filesPage, minThickness: 200)
        fileSplit.add(infosPage, minThickness: 200)
        mainSplit.add(fileSplit, minThickness: 300)
        mainSplit.add(detailPage, minThickness: 200, maxThickness: 500)
        
        contentViewController = mainSplit
        
        let bar = NSToolbar(identifier: .mainToolbar)
        bar.delegate = self
        bar.displayMode = .iconOnly
        bar.sizeMode = .default
        bar.showsBaselineSeparator = true
        toolbar = bar
        
        title = "Breeder"
        contentViewController = mainSplit
        minSize = NSMakeSize(720, 540)
        setFrame(NSMakeRect(0, 0, 720, 540), display: true)
        titlebarAppearsTransparent = false
        titlebarSeparatorStyle = .line
        toolbarStyle = .unifiedCompact
        center()
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ .filesGroup, .expandGroup ]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ .filesGroup, .expandGroup ]
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return []
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == .filesGroup {
            return NSToolbarItemGroup(itemIdentifier: .filesGroup, sfnames: [ .plus, .squareAndArrowDown, .squareAndArrowUp ], selectionModel: .momentary, labels: nil, target: self, action: #selector(filesGroupAction))
        }
        
        if itemIdentifier == .expandGroup {
            return NSToolbarItemGroup(itemIdentifier: .expandGroup, sfnames: [ .rectangleTophalfFilled, .rectangleRighthalfFilled ], selectionModel: .momentary, labels: nil, target: self, action: #selector(expandsAction))
        }
        
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }
}

private extension MainWindow {
    @objc func filesGroupAction(_ itemGroup: NSToolbarItemGroup) {
        if itemGroup.selectedIndex == 0 {
            DataCenter.shared.files.append(FileInfo())
        }
    }
    
    @objc func expandsAction(_ itemGroup: NSToolbarItemGroup) {
        let firstItem = (itemGroup.selectedIndex == 0 ? fileSplit : mainSplit).splitViewItems[itemGroup.selectedIndex]
        firstItem.isCollapsed = !firstItem.isCollapsed
    }
}
