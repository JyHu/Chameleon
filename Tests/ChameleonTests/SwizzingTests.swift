//
//  SwizzlingTests.swift
//  
//
//  Created by Jo on 2023/4/14.
//

import XCTest

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

@testable import Chameleon

final class SwizzlingTests: XCTestCase {

    func testExample() throws {
        AppearanceManager.activeSwizzling()
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        let theme0 = ThemeInfos.Theme0.self
        
        #if os(macOS)
        let box = NSBox()
        box.fillColor = theme0.C001
        box.borderColor = theme0.C002
        
        let button = NSButton()
        button.bezelColor = theme0.C001
        button.contentTintColor = theme0.C002
        button.attributedTitle = NSAttributedString("test", theme0.C003)
        button.image = theme0.appearancedImage01
        button.alternateImage = theme0.appearancedImage02
        
        let buttonTouchBarItem = NSButtonTouchBarItem(identifier: NSTouchBarItem.Identifier("aaa"))
        buttonTouchBarItem.image = theme0.appearancedImage03
        buttonTouchBarItem.bezelColor = theme0.C005
        
        let clipView = NSClipView()
        clipView.backgroundColor = theme0.C006
        
        let collectionView = NSCollectionView()
        collectionView.backgroundColors = [theme0.C005, theme0.C008]
        
        let datePicker = NSDatePicker()
        datePicker.textColor = theme0.C007
        datePicker.backgroundColor = theme0.C004
        
        let levelIndicator = NSLevelIndicator()
        levelIndicator.fillColor = theme0.C001
        levelIndicator.warningFillColor = theme0.C002
        levelIndicator.criticalFillColor = theme0.C003
        
        let pathControl = NSPathControl()
        pathControl.backgroundColor = theme0.C003
        pathControl.placeholderAttributedString = NSAttributedString("hello", theme0.C005)
        
        let pathControlItem = NSPathControlItem()
        pathControlItem.attributedTitle = NSAttributedString("hello", theme0.C008)
        
        let scrollView = NSScrollView()
        scrollView.backgroundColor = theme0.C002
        
        let segmentedControl = NSSegmentedControl()
        segmentedControl.selectedSegmentBezelColor = theme0.C003
        
        let slider = NSSlider()
        slider.trackFillColor = theme0.C004
        
        let tableRowView = NSTableRowView()
        tableRowView.backgroundColor = theme0.C008
        
        let tableView = NSTableView()
        tableView.backgroundColor = theme0.C001
        tableView.gridColor = theme0.C005
        
        let text = NSText()
        text.string = "hello world"
        text.textColor = theme0.C007
        text.backgroundColor = theme0.C005
        
        let textView = NSTextView()
        textView.textColor = theme0.C006
        textView.backgroundColor = theme0.C001
        textView.insertionPointColor = theme0.C003
        
        let textField = NSTextField()
        textField.backgroundColor = theme0.C004
        textField.textColor = theme0.C008
        textField.attributedStringValue = NSAttributedString("hello", theme0.C003)
        textField.placeholderAttributedString = NSAttributedString("placeholder", theme0.C003)
        
        let window = NSWindow()
        window.backgroundColor = theme0.C001
        
        #else
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = theme0.C001
        
        let button = UIButton(type: .custom)
        button.tintColor = theme0.C001
        button.setTitleColor(theme0.C002, for: .normal)
        button.setTitleColor(theme0.C003, for: .disabled)
        button.setTitleColor(theme0.C004, for: .highlighted)
        button.setTitleColor(theme0.C005, for: .selected)
        button.setAttributedTitle(NSAttributedString("a", theme0.C006), for: .normal)
        button.setAttributedTitle(NSAttributedString("b", theme0.C007), for: .disabled)
        button.setAttributedTitle(NSAttributedString("c", theme0.C008), for: .highlighted)
        button.setAttributedTitle(NSAttributedString("d", theme0.C001), for: .selected)
        
        let imageView = UIImageView()
        imageView.tintColor = theme0.C006
        imageView.setAnimationDuration(3, identifier: "others/imageView/animationDuration")
        imageView.setAnimationRepeatCount(1, identifier: "others/imageView/animationRepeatCount")
        
        let label = UILabel()
        label.textColor = theme0.C001
        label.shadowColor = theme0.C002
        label.highlightedTextColor = theme0.C003
        /// attributedText和textColor有冲突，如果同时设置了，那么再单测的时候会失败
//        label.attributedText = NSAttributedString("Hello", theme0.C006)
        
        let navigationBar = UINavigationBar()
        navigationBar.tintColor = theme0.C006
        navigationBar.barTintColor = theme0.C001
        navigationBar.titleTextAttributes = [.foregroundColor: theme0.C002, .backgroundColor: theme0.C003, .baselineOffset: 3, .kern: 5]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: theme0.C002, .backgroundColor: theme0.C003, .baselineOffset: 3, .kern: 7]
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = theme0.C001
        pageControl.currentPageIndicatorTintColor = theme0.C003
        pageControl.backgroundColor = theme0.C004
        
        let progressView = UIProgressView()
        progressView.progressTintColor = theme0.C002
        progressView.trackTintColor = theme0.C004
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString("Hello", theme0.C005)
        
        let searchBar = UISearchBar()
        searchBar.barTintColor = theme0.C008 /// barTintColor不支持alpha通道，设置了也不生效，所以测试的时候需要用不带alpha的颜色
        searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: theme0.C001, .backgroundColor: theme0.C002], for: .normal)
        searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: theme0.C003, .backgroundColor: theme0.C004], for: .highlighted)
        searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: theme0.C005, .backgroundColor: theme0.C006], for: .disabled)
        
        var searchTextField: Any?
        if #available(iOS 13.0, *) {
            searchTextField = UISearchTextField()
            (searchTextField as! UISearchTextField).tokenBackgroundColor = theme0.C007
        }
        
        let segmentedControl = UISegmentedControl()
        segmentedControl.setTitleTextAttributes([.foregroundColor: theme0.C001, .backgroundColor: theme0.C002], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: theme0.C003, .backgroundColor: theme0.C004], for: .highlighted)
        segmentedControl.setTitleTextAttributes([.foregroundColor: theme0.C005, .backgroundColor: theme0.C006], for: .disabled)
        segmentedControl.setTitleTextAttributes([.foregroundColor: theme0.C007, .backgroundColor: theme0.C008], for: .selected)
        
        let slider = UISlider()
        slider.minimumTrackTintColor = theme0.C001
        slider.maximumTrackTintColor = theme0.C002
        slider.thumbTintColor = theme0.C003
        
        let switchControl = UISwitch()
        switchControl.onTintColor = theme0.C005
        switchControl.thumbTintColor = theme0.C006
        
        let tabbar = UITabBar()
        tabbar.barTintColor = theme0.C007
        tabbar.unselectedItemTintColor = theme0.C008
        
        let tableView = UITableView()
        tableView.sectionIndexColor = theme0.C001
        tableView.sectionIndexBackgroundColor = theme0.C002
        tableView.sectionIndexTrackingBackgroundColor = theme0.C003
        tableView.separatorColor = theme0.C004
        
        let textField = UITextField()
        textField.attributedText = NSAttributedString("Hello", theme0.C003)
//        textField.textColor = theme0.C004
//        textField.defaultTextAttributes = [.foregroundColor: theme0.C005, .backgroundColor: theme0.C006]
        textField.attributedPlaceholder = NSAttributedString("world", theme0.C007)
//        textField.typingAttributes = [.foregroundColor: theme0.C008, .backgroundColor: theme0.C002]
        
        let toolbar = UIToolbar()
        toolbar.barTintColor = theme0.C006
        
        let view = UIView()
        view.backgroundColor = theme0.C001
        view.tintColor = theme0.C002
        
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
                
                XCTAssertTrue(navigationBar.titleTextAttributes?.attributes(equalTo: [.foregroundColor: cls.C002, .backgroundColor: cls.C003, .baselineOffset: 3, .kern: 5]) ?? false)
                XCTAssertTrue(navigationBar.largeTitleTextAttributes?.attributes(equalTo: [.foregroundColor: cls.C002, .backgroundColor: cls.C003, .baselineOffset: 3, .kern: 7]) ?? false)
                
                XCTAssertEqual(pageControl.pageIndicatorTintColor, cls.C001)
                XCTAssertEqual(pageControl.currentPageIndicatorTintColor, cls.C003)
                XCTAssertEqual(pageControl.backgroundColor, cls.C004)
                
                XCTAssertEqual(progressView.progressTintColor, cls.C002)
                XCTAssertEqual(progressView.trackTintColor, cls.C004)
                
                XCTAssertTrue(refreshControl.attributedTitle!.appearanceEqual(to: cls.C005))
                
                XCTAssertEqual(searchBar.barTintColor, cls.C008)
//                XCTAssertTrue(searchBar.scopeBarButtonTitleTextAttributes(for: .normal)?.attributes(equalTo: [.foregroundColor: cls.C001, .backgroundColor: cls.C002]) ?? false)
                XCTAssertTrue(searchBar.scopeBarButtonTitleTextAttributes(for: .highlighted)?.attributes(equalTo: [.foregroundColor: cls.C003, .backgroundColor: cls.C004]) ?? false)
                XCTAssertTrue(searchBar.scopeBarButtonTitleTextAttributes(for: .disabled)?.attributes(equalTo: [.foregroundColor: cls.C005, .backgroundColor: cls.C006]) ?? false)
                
                if #available(iOS 13.0, *) {
                    XCTAssertEqual((searchTextField as! UISearchTextField).tokenBackgroundColor, cls.C007)
                }
                
                XCTAssertTrue(segmentedControl.titleTextAttributes(for: .normal)?.attributes(equalTo: [.foregroundColor: cls.C001, .backgroundColor: cls.C002]) ?? false)
                XCTAssertTrue(segmentedControl.titleTextAttributes(for: .highlighted)?.attributes(equalTo: [.foregroundColor: cls.C003, .backgroundColor: cls.C004]) ?? false)
                XCTAssertTrue(segmentedControl.titleTextAttributes(for: .disabled)?.attributes(equalTo: [.foregroundColor: cls.C005, .backgroundColor: cls.C006]) ?? false)
                XCTAssertTrue(segmentedControl.titleTextAttributes(for: .selected)?.attributes(equalTo: [.foregroundColor: cls.C007, .backgroundColor: cls.C008]) ?? false)
                
                XCTAssertEqual(slider.minimumTrackTintColor, cls.C001)
                XCTAssertEqual(slider.maximumTrackTintColor, cls.C002)
                XCTAssertEqual(slider.thumbTintColor, cls.C003)
                
                XCTAssertEqual(switchControl.onTintColor, cls.C005)
                XCTAssertEqual(switchControl.thumbTintColor, cls.C006)
                
                XCTAssertEqual(tabbar.barTintColor, cls.C007)
                XCTAssertEqual(tabbar.unselectedItemTintColor, cls.C008)
                
                XCTAssertEqual(tableView.sectionIndexColor, cls.C001)
                XCTAssertEqual(tableView.sectionIndexBackgroundColor, cls.C002)
                XCTAssertEqual(tableView.sectionIndexTrackingBackgroundColor, cls.C003)
                XCTAssertEqual(tableView.separatorColor, cls.C004)
                
                
                XCTAssertTrue(textField.attributedText?.appearanceEqual(to: cls.C003) ?? false)
//                XCTAssertEqual(textField.textColor, cls.C004)
//                XCTAssertTrue(textField.defaultTextAttributes.attributes(equalTo: [.foregroundColor: cls.C005, .backgroundColor: cls.C006]))
                XCTAssertTrue(textField.attributedPlaceholder?.appearanceEqual(to: cls.C007) ?? false)
//                XCTAssertTrue(textField.typingAttributes?.attributes(equalTo: [.foregroundColor: cls.C008, .backgroundColor: cls.C002]) ?? false)
                
                XCTAssertEqual(toolbar.barTintColor, cls.C006)
                
                XCTAssertEqual(view.backgroundColor, cls.C001)
                XCTAssertEqual(view.tintColor, cls.C002)
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
