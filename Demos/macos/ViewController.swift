//
//  ViewController.swift
//  macos
//
//  Created by Jo on 2023/4/4.
//

import Cocoa
import Chameleon

class ViewController: NSViewController {

    @IBOutlet weak var testView: NSView!
    
    @IBOutlet weak var testBox: NSBox!
    
    @IBOutlet var testTextView: NSTextView!
    
    @IBOutlet weak var testTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Chameleon.exchangeImplementations()
        Chameleon.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        testBox.borderWidth = 5
        
        testView.app_layerBackgroundColor = .C101
        testView.app_layerBorderColor = .C108
        testView.layer?.borderWidth = 5
        
        testBox.app_borderColor = .C001
        testBox.app_fillColor = .C002
        testTextView.app_backgroundColor = .C003
        testTextView.app_textColor = .C004
        testTextField.app_backgroundColor = .C107
        testTextField.app_textColor = .C005
        
        
//        testBox.borderColor = .c002
//        testBox.fillColor = .priceColor
//        testTextView.backgroundColor = .link
//        testTextView.textColor = .priceColor
    }

    @IBAction func switchThemeAction(_ sender: NSSegmentedControl) {
        if sender.indexOfSelectedItem == 0 {
            Chameleon.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        } else if sender.indexOfSelectedItem == 1 {
            Chameleon.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        } else if sender.indexOfSelectedItem == 2 {
            Chameleon.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        }
    }
}

