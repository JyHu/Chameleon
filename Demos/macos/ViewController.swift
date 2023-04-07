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
    
    @IBOutlet weak var multilineLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AppearanceManager.exchangeImplementations()
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        testBox.customized(color1: .C101, color2: .C103)
        
        testBox.borderWidth = 5

        testView.app_layerBackgroundColor = .C101
        testView.app_layerBorderColor = .C108
        testView.layer?.borderWidth = 5

        testBox.app_borderColor = .C001
        testBox.app_fillColor = .C002
        testBox.app_borderWidth = 5
        testTextView.app_backgroundColor = .C003
        testTextView.app_textColor = .C004
        testTextField.app_backgroundColor = .C107
        testTextField.app_textColor = .C005
        
        let attributedString = NSMutableAttributedString(string: "Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.")
        attributedString.addAttributes([.foregroundColor: NSColor.C002], range: NSMakeRange(0, 4))
        attributedString.addAttributes([.foregroundColor: NSColor.C006], range: NSMakeRange(8, 5))
        attributedString.addAttributes([.font: NSFont.systemFont(ofSize: 18)], range: NSMakeRange(2, 10))
        multilineLabel.app_attributedStringValue = attributedString
        
//        testBox.borderColor = .c002
//        testBox.fillColor = .priceColor
//        testTextView.backgroundColor = .link
//        testTextView.textColor = .priceColor
    }

    @IBAction func switchThemeAction(_ sender: NSSegmentedControl) {
        if sender.indexOfSelectedItem == 0 {
            AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        } else if sender.indexOfSelectedItem == 1 {
            AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        } else if sender.indexOfSelectedItem == 2 {
            AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        }
    }
}

