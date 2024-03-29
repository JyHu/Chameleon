# Chameleon

Chameleon is a theme framework designed for iOS/macOS, which allows for dynamic theme changes and customization of attributes. It also supports non-intrusive theme changes (swizzling) to alter the interface style. In other words, Chameleon provides a convenient way for developers to implement theme changes and custom attribute functionality in their applications without requiring extensive modifications to the existing codebase.

## Requirements

- iOS 11.0+/ macOS 10.13+
- Xcode 10.0+
- Swift 5.0+

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

```
dependencies: [
    .package(url: "https://github.com/JyHu/Chameleon.git", .upToNextMajor(from: "0.1.0"))
]
```

### Cocoapods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate Chameleon into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
# platform: macos, '10.13'
use_frameworks!

target '<Your Target Name>' do
    pod 'Chameleon', :git => 'https://github.com/JyHu/Chameleon.git'
end
```

Then, run the following command:

```
$ pod install
```

## Resources

- [Documentation](Resources/Docs.md)

## License

Chameleon is released under the MIT license. See LICENSE for details.
