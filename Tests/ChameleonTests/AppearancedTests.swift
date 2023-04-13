import XCTest

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

@testable import Chameleon

final class AppearancedTests: XCTestCase {
    func testExample() throws {
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        let theme0 = ThemeInfos.Theme0.self
        
        #if os(macOS)
        let box = NSBox()
        box.app_fillColor = theme0.C001
        box.app_borderColor = theme0.C002
        
        let button = NSButton()
        button.app_bezelColor = theme0.C001
        button.app_contentTintColor = theme0.C002
        button.app_attributedTitle = NSAttributedString("test", theme0.C003)
        button.app_image = theme0.appearancedImage01
        button.app_alternateImage = theme0.appearancedImage02
        
        let buttonTouchBarItem = NSButtonTouchBarItem(identifier: NSTouchBarItem.Identifier("aaa"))
        buttonTouchBarItem.app_image = theme0.appearancedImage03
        buttonTouchBarItem.app_bezelColor = theme0.C005
        
        let clipView = NSClipView()
        clipView.app_backgroundColor = theme0.C006
        
        let collectionView = NSCollectionView()
        collectionView.app_backgroundColors = [theme0.C005, theme0.C008]
        
        let datePicker = NSDatePicker()
        datePicker.app_textColor = theme0.C007
        datePicker.app_backgroundColor = theme0.C004
        
        let levelIndicator = NSLevelIndicator()
        levelIndicator.app_fillColor = theme0.C001
        levelIndicator.app_warningFillColor = theme0.C002
        levelIndicator.app_criticalFillColor = theme0.C003
        
        let pathControl = NSPathControl()
        pathControl.app_backgroundColor = theme0.C003
        pathControl.app_placeholderAttributedString = NSAttributedString("hello", theme0.C005)
        
        let pathControlItem = NSPathControlItem()
        pathControlItem.app_attributedTitle = NSAttributedString("hello", theme0.C008)
        
        let scrollView = NSScrollView()
        scrollView.app_backgroundColor = theme0.C002
        
        let segmentedControl = NSSegmentedControl()
        segmentedControl.app_selectedSegmentBezelColor = theme0.C003
        
        let slider = NSSlider()
        slider.app_trackFillColor = theme0.C004
        
        let tableRowView = NSTableRowView()
        tableRowView.app_backgroundColor = theme0.C008
        
        let tableView = NSTableView()
        tableView.app_backgroundColor = theme0.C001
        tableView.app_gridColor = theme0.C005
        
        let text = NSText()
        text.string = "hello world"
        text.app_text_textColor = theme0.C007
        text.app_text_backgroundColor = theme0.C005
        
        let textView = NSTextView()
        textView.app_textColor = theme0.C006
        textView.app_backgroundColor = theme0.C001
        textView.app_insertionPointColor = theme0.C003
        
        let textField = NSTextField()
        textField.app_backgroundColor = theme0.C004
        textField.app_textColor = theme0.C008
        textField.app_attributedStringValue = NSAttributedString("hello", theme0.C003)
        textField.app_placeholderAttributedString = NSAttributedString("placeholder", theme0.C003)
        
        let view = NSView()
        view.app_layerBackgroundColor = theme0.C002
        view.app_layerBorderColor = theme0.C006
        
        let window = NSWindow()
        window.app_backgroundColor = theme0.C001
        
        #else
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.app_color = theme0.C001
        
        let button = UIButton(type: .custom)
        button.app_tintColor = theme0.C001
        button.app_setTitleColor(theme0.C002, for: .normal)
        button.app_setTitleColor(theme0.C003, for: .disabled)
        button.app_setTitleColor(theme0.C004, for: .highlighted)
        button.app_setTitleColor(theme0.C005, for: .selected)
        button.app_setAttributedTitle(NSAttributedString("a", theme0.C006), for: .normal)
        button.app_setAttributedTitle(NSAttributedString("b", theme0.C007), for: .disabled)
        button.app_setAttributedTitle(NSAttributedString("c", theme0.C008), for: .highlighted)
        button.app_setAttributedTitle(NSAttributedString("d", theme0.C001), for: .selected)
        
        let imageView = UIImageView()
        imageView.app_tintColor = theme0.C006
        imageView.setAnimationDuration(3, identifier: "others/imageView/animationDuration")
        imageView.setAnimationRepeatCount(1, identifier: "others/imageView/animationRepeatCount")
        
        let label = UILabel()
        label.app_textColor = theme0.C001
        label.app_shadowColor = theme0.C002
        label.app_highlightedTextColor = theme0.C003
        /// attributedText和textColor有冲突，如果同时设置了，那么再单测的时候会失败
//        label.app_attributedText = NSAttributedString("Hello", theme0.C006)
        
        let navigationBar = UINavigationBar()
        navigationBar.app_tintColor = theme0.C006
        navigationBar.app_barTintColor = theme0.C001
        navigationBar.app_titleTextAttributes = [.foregroundColor: theme0.C002, .backgroundColor: theme0.C003, .baselineOffset: 3, .kern: 5]
        navigationBar.app_largeTitleTextAttributes = [.foregroundColor: theme0.C002, .backgroundColor: theme0.C003, .baselineOffset: 3, .kern: 7]
        
        let pageControl = UIPageControl()
        pageControl.app_pageIndicatorTintColor = theme0.C001
        pageControl.app_currentPageIndicatorTintColor = theme0.C003
        
        let progressView = UIProgressView()
        progressView.app_progressTintColor = theme0.C002
        progressView.app_trackTintColor = theme0.C004
        
        #endif
        
        func checkAppearance<T>(cls: T.Type, all: Bool) where T: TestThemeInfosProtocol {
            #if os(macOS)
            func checkEqual() {
                XCTAssertEqual(box.fillColor, cls.C001)
                XCTAssertEqual(box.borderColor, cls.C002)
                
                XCTAssertEqual(button.bezelColor, cls.C001)
                XCTAssertEqual(button.contentTintColor, cls.C002)
                XCTAssertTrue(button.attributedTitle.appearanceEqual(to: cls.C003))
                
                XCTAssertEqual(buttonTouchBarItem.bezelColor, cls.C005)
                
                XCTAssertEqual(clipView.backgroundColor, cls.C006)
                
                XCTAssertEqual(collectionView.backgroundColors, [cls.C005, cls.C008])
                
                XCTAssertEqual(datePicker.textColor, cls.C007)
                XCTAssertEqual(datePicker.backgroundColor, cls.C004)
                
                XCTAssertEqual(levelIndicator.fillColor, cls.C001)
                XCTAssertEqual(levelIndicator.warningFillColor, cls.C002)
                XCTAssertEqual(levelIndicator.criticalFillColor, cls.C003)
                
                XCTAssertEqual(pathControl.backgroundColor, cls.C003)
                XCTAssertTrue(pathControl.placeholderAttributedString?.appearanceEqual(to: cls.C005) ?? false)
                
                XCTAssertTrue(pathControlItem.attributedTitle.appearanceEqual(to: cls.C008))
                
                XCTAssertEqual(scrollView.backgroundColor, cls.C002)
                
                XCTAssertEqual(segmentedControl.selectedSegmentBezelColor, cls.C003)
                
                XCTAssertEqual(slider.trackFillColor, cls.C004)
                
                XCTAssertEqual(tableRowView.backgroundColor, cls.C008)
                
                XCTAssertEqual(tableView.backgroundColor, cls.C001)
                XCTAssertEqual(tableView.gridColor, cls.C005)
                
                XCTAssertEqual(text.textColor, cls.C007)
                XCTAssertEqual(text.backgroundColor, cls.C005)
                
                XCTAssertEqual(textView.textColor, cls.C006)
                XCTAssertEqual(textView.backgroundColor, cls.C001)
                XCTAssertEqual(textView.insertionPointColor, cls.C003)
                
                XCTAssertEqual(textField.backgroundColor, cls.C004)
                XCTAssertEqual(textField.textColor, cls.C008)
                XCTAssertTrue(textField.attributedStringValue.appearanceEqual(to: cls.C003))
                XCTAssertTrue(textField.placeholderAttributedString?.appearanceEqual(to: cls.C003) ?? false)
                
                XCTAssertEqual(view.app_layerBackgroundColor, cls.C002)
                XCTAssertEqual(view.app_layerBorderColor, cls.C006)
                
                XCTAssertEqual(window.backgroundColor, cls.C001)
            }
            
            func checkNotEqual() {
                XCTAssertNotEqual(box.fillColor, theme0.C001)
                XCTAssertNotEqual(box.borderColor, theme0.C002)
                
                XCTAssertNotEqual(button.bezelColor, theme0.C001)
                XCTAssertNotEqual(button.contentTintColor, theme0.C002)
                XCTAssertFalse(button.attributedTitle.appearanceEqual(to: theme0.C003))

                XCTAssertNotEqual(buttonTouchBarItem.bezelColor, theme0.C005)
                
                XCTAssertNotEqual(clipView.backgroundColor, theme0.C006)
                
                XCTAssertNotEqual(collectionView.backgroundColors, [cls.C005, theme0.C008])
                
                XCTAssertNotEqual(datePicker.textColor, theme0.C007)
                XCTAssertNotEqual(datePicker.backgroundColor, theme0.C004)
                
                XCTAssertNotEqual(levelIndicator.fillColor, theme0.C001)
                XCTAssertNotEqual(levelIndicator.warningFillColor, theme0.C002)
                XCTAssertNotEqual(levelIndicator.criticalFillColor, theme0.C003)
                
                XCTAssertNotEqual(pathControl.backgroundColor, theme0.C003)
                XCTAssertFalse(pathControl.placeholderAttributedString?.appearanceEqual(to: theme0.C005) ?? false)
                
                XCTAssertFalse(pathControlItem.attributedTitle.appearanceEqual(to: theme0.C008))
                
                XCTAssertNotEqual(scrollView.backgroundColor, theme0.C002)
                
                XCTAssertNotEqual(segmentedControl.selectedSegmentBezelColor, theme0.C003)
                
                XCTAssertNotEqual(slider.trackFillColor, theme0.C004)
                
                XCTAssertNotEqual(tableRowView.backgroundColor, theme0.C008)
                
                XCTAssertNotEqual(tableView.backgroundColor, theme0.C001)
                XCTAssertNotEqual(tableView.gridColor, theme0.C005)
                
                XCTAssertNotEqual(text.textColor, theme0.C007)
                XCTAssertNotEqual(text.backgroundColor, theme0.C005)
                
                XCTAssertNotEqual(textView.textColor, theme0.C006)
                XCTAssertNotEqual(textView.backgroundColor, theme0.C001)
                XCTAssertNotEqual(textView.insertionPointColor, theme0.C003)
                
                XCTAssertNotEqual(textField.backgroundColor, theme0.C004)
                XCTAssertNotEqual(textField.textColor, theme0.C008)
                XCTAssertFalse(textField.attributedStringValue.appearanceEqual(to: theme0.C003))
                XCTAssertFalse(textField.placeholderAttributedString?.appearanceEqual(to: theme0.C003) ?? false)
                
                XCTAssertNotEqual(view.app_layerBackgroundColor, theme0.C002)
                XCTAssertNotEqual(view.app_layerBorderColor, theme0.C006)
                
                XCTAssertNotEqual(window.backgroundColor, theme0.C001)
            }
            #else
            func checkEqual() {
                XCTAssertEqual(activityIndicator.color, cls.C001)

                XCTAssertEqual(button.tintColor, cls.C001)
                XCTAssertEqual(button.titleColor(for: .normal), cls.C002)
                XCTAssertEqual(button.titleColor(for: .disabled), cls.C003)
                XCTAssertEqual(button.titleColor(for: .highlighted), cls.C004)
                XCTAssertEqual(button.titleColor(for: .selected), cls.C005)
                XCTAssertTrue(button.attributedTitle(for: .normal)?.appearanceEqual(to: cls.C006) ?? false)
                XCTAssertTrue(button.attributedTitle(for: .disabled)?.appearanceEqual(to: cls.C007) ?? false)
                XCTAssertTrue(button.attributedTitle(for: .highlighted)?.appearanceEqual(to: cls.C008) ?? false)
                XCTAssertTrue(button.attributedTitle(for: .selected)?.appearanceEqual(to: cls.C001) ?? false)

                XCTAssertEqual(imageView.tintColor, cls.C006)
                
                XCTAssertEqual(label.textColor, cls.C001)
                XCTAssertEqual(label.shadowColor, cls.C002)
                XCTAssertEqual(label.highlightedTextColor, cls.C003)
//                XCTAssertTrue(label.attributedText?.appearanceEqual(to: cls.C006) ?? false)
                
                XCTAssertEqual(navigationBar.tintColor, cls.C006)
                XCTAssertEqual(navigationBar.barTintColor, cls.C001)
                
                testDictEqual(dict1: navigationBar.titleTextAttributes, dict2Block: [.foregroundColor: cls.C002, .backgroundColor: cls.C003, .baselineOffset: 3, .kern: 5]) { key, v1, v2 in
                    if key == .foregroundColor { return (v1 as! NSUIAppearanceColor) == (v2 as! NSUIAppearanceColor) }
                    if key == .backgroundColor { return (v1 as! NSUIAppearanceColor) == (v2 as! NSUIAppearanceColor) }
                    if key == .baselineOffset { return (v1 as! Int) == (v2 as! Int) }
                    if key == .kern { return (v1 as! Int) == (v2 as! Int) }
                    return true
                }
                
                testDictEqual(dict1: navigationBar.largeTitleTextAttributes, dict2Block: [.foregroundColor: cls.C002, .backgroundColor: cls.C003, .baselineOffset: 3, .kern: 7]) { key, v1, v2 in
                    if key == .foregroundColor { return (v1 as! NSUIAppearanceColor) == (v2 as! NSUIAppearanceColor) }
                    if key == .backgroundColor { return (v1 as! NSUIAppearanceColor) == (v2 as! NSUIAppearanceColor) }
                    if key == .baselineOffset { return (v1 as! Int) == (v2 as! Int) }
                    if key == .kern { return (v1 as! Int) == (v2 as! Int) }
                    return true
                }
                
                XCTAssertEqual(pageControl.pageIndicatorTintColor, cls.C001)
                XCTAssertEqual(pageControl.currentPageIndicatorTintColor, cls.C003)
                
                XCTAssertEqual(progressView.progressTintColor, cls.C002)
                XCTAssertEqual(progressView.trackTintColor, cls.C004)
            }
            
            func checkNotEqual() {
                
            }
            #endif
            if all {
                checkEqual()
                checkNotEqual()
            } else {
                checkEqual()
            }
        }
        
        checkAppearance(cls: ThemeInfos.Theme0.self, all: false)
        
#if os(iOS)
        XCTAssertEqual(imageView.animationDuration, 1)
        XCTAssertEqual(imageView.animationRepeatCount, 3)
#endif
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        checkAppearance(cls: ThemeInfos.Theme1.self, all: true)

#if os(iOS)
        XCTAssertEqual(imageView.animationDuration, 3)
        XCTAssertEqual(imageView.animationRepeatCount, 5)
#endif
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        
        checkAppearance(cls: ThemeInfos.Theme2.self, all: true)
        
#if os(iOS)
        XCTAssertEqual(imageView.animationDuration, 5)
        XCTAssertEqual(imageView.animationRepeatCount, 7)
#endif
    }
    
    func testUnit() throws {
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
//        let theme0 = ThemeInfos.Theme0.self
        
//        let label = UILabel()
//        label.app_textColor = theme0.C001
//        label.app_shadowColor = theme0.C002
//        label.app_highlightedTextColor = theme0.C003
////        label.app_attributedText = NSAttributedString("Hello", theme0.C006)
//
        func checkAppearance<T>(cls: T.Type, all: Bool) where T: TestThemeInfosProtocol {
//            XCTAssertEqual(label.textColor, cls.C001)
//            XCTAssertEqual(label.shadowColor, cls.C002)
//            XCTAssertEqual(label.highlightedTextColor, cls.C003)
////            XCTAssertTrue(label.attributedText?.appearanceEqual(to: cls.C006) ?? false)
        }
        
        checkAppearance(cls: ThemeInfos.Theme0.self, all: false)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        checkAppearance(cls: ThemeInfos.Theme1.self, all: true)

        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        
        checkAppearance(cls: ThemeInfos.Theme2.self, all: true)
    }
    
    func testDictEqual<K, V>(dict1: [K: V], dict2Block: @autoclosure () -> [K: V]) where K: Hashable, V: Equatable {
        let dict2 = dict2Block()
        
        XCTAssertEqual(dict1.count, dict2.count)
        
        for (k, v) in dict1 {
            let tv = dict2[k]
            XCTAssertNotNil(tv)
            XCTAssertEqual(v, tv!)
        }
    }
    
    func testDictEqual<K, V>(dict1: [K: V]?, dict2Block: @autoclosure () -> [K: V]?, compare: (K, V, V) -> Bool) where K: Hashable {
        let dict2 = dict2Block()
        
        if dict1 == nil && dict2 == nil {
            return
        }
        
        guard let dict1, let dict2 else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(dict1.count, dict2.count)
        
        for (k, v) in dict1 {
            let tv = dict2[k]
            XCTAssertNotNil(tv)
            
            XCTAssertTrue(compare(k, v, tv!))
        }
    }
    
    func testLargeKits() {
        measure {
            let theme0 = ThemeInfos.Theme0.self
            var kits: [Any] = []
            
            AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
            
            for _ in 0..<10000 {
                #if os(macOS)
                let label = NSTextField(labelWithString: "hello")
                label.textColor = theme0.C001
                kits.append(label)
                #else
                let button = UIButton(type: .custom)
                button.app_tintColor = theme0.C001
                button.app_setTitleColor(theme0.C002, for: .normal)
                button.app_setTitleColor(theme0.C003, for: .disabled)
                button.app_setTitleColor(theme0.C004, for: .highlighted)
                button.app_setTitleColor(theme0.C005, for: .selected)
                button.app_setAttributedTitle(NSAttributedString("a", theme0.C006), for: .normal)
                button.app_setAttributedTitle(NSAttributedString("b", theme0.C007), for: .disabled)
                button.app_setAttributedTitle(NSAttributedString("c", theme0.C008), for: .highlighted)
                button.app_setAttributedTitle(NSAttributedString("d", theme0.C001), for: .selected)
                kits.append(button)
                #endif
            }
            
            AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        }
    }
}

extension NSAttributedString {
    func appearanceEqual(to color: NSUIAppearanceColor) -> Bool {
        var equals: Bool = false
        
        enumerateAttribute(.foregroundColor, in: NSMakeRange(0, self.length)) { value, range, stop in
            
            if color == value as? NSUIAppearanceColor {
                equals = true
                stop.pointee = true
            }
        }
        
        return equals
    }
    
    convenience init(_ text: String, _ color: NSUIAppearanceColor) {
        self.init(string: text, attributes: [.foregroundColor: color])
    }
}
