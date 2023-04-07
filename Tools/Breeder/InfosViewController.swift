//
//  InfosViewController.swift
//  Breeder
//
//  Created by Jo on 2023/4/7.
//

import Cocoa
import SwiftExtensions

class InfosViewController: NSViewController {

    private var outlineView = NSOutlineView(frame: NSMakeRect(0, 0, 100, 100))
    
    override func loadView() {
        view = NSScrollView(documentView: outlineView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineView.focusRingType = .none
    }    
}
