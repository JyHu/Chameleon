//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#endif

/// 内部调用
internal extension AppearanceManager {
    static func exchangeImplementations() {
#if os(macOS)
        NSBox.silenceExchangeBoxImplementation()
        NSButton.silenceExchangeButtonImplementation()
        NSDatePicker.silenceExchangeDatePickerViewImplementation()
        NSImageView.silenceExchangeImageViewImplementation()
        NSScrollView.silenceExchangeScrollViewImplementation()
        NSSlider.silenceExchangeSliderImplementation()
        NSTableView.silenceExchangeTableViewImplementation()
        NSText.silenceExchangeTextImplementation()
        NSTextField.silenceExchangeTextFieldImplementation()
        NSTextView.silenceExchangeTextViewImplementation()
        /// NSView
        NSWindow.silenceExchangeWindowImplementation()
        NSClipView.silenceExchangeClipViewImplementation()
        NSPathControl.silenceExchangePathControlImplementation()
        NSPathControlItem.silenceExchangePathControlItemImplementation()
        NSTableRowView.silenceExchangeTableRowViewImplementation()
        NSSegmentedControl.silenceExchangeSegmentedControlImplementation()
        NSLevelIndicator.silenceExchangeLevelIndicatorImplementation()
        NSCollectionView.silenceExchangeCollectionViewImplementation()
        
        if #available(macOS 10.15, *) {
            NSButtonTouchBarItem.silenceExchangeButtonTouchBarItemImplementation()        
        }
#elseif canImport(UIKit)
        UIButton.silenceExchangeButtonImplementation()
        UILabel.silenceExchangeLabelImplementation()
        UIView.silenceExchangeViewImplementation()
        UIActivityIndicatorView.silenceExchangeActivityIndicatorViewImplementation()
        UIBarItem.silenceExchangeBarItemImplementation()
        UIImageView.silenceExchangeImageViewImplementation()
        UINavigationBar.silenceExchangeNavigationBarImplementation()
        UIPageControl.silenceExchangePageControlImplementation()
        UIProgressView.silenceExchangeProgressViewImplementation()
        UIRefreshControl.silenceExchangeRefreshControlImplementation()
        UISearchBar.silenceExchangeSearchBarImplementation()
        UISegmentedControl.silenceExchangeSegmentedControlImplementation()
        UISlider.silenceExchangeSliderImplementation()
        UIStepper.silenceExchangeStepperImplementation()
        UISwitch.silenceExchangeSwitchImplementation()
        UITabBar.silenceExchangeTabBarImplementation()
        UITableView.silenceExchangeTableViewImplementation()
        UITextField.silenceExchangeTextFieldImplementation()
        UITextView.silenceExchangeTextViewImplementation()
        UIToolbar.silenceExchangeToolbarImplementation()
        
        if #available(iOS 13.0, *) {
            UISearchTextField.silenceExchangeSearchTextFieldImplementation()
        }
#endif
    }
}
