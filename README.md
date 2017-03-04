# STCameraPicker
> A UIViewController subclass a la UIImagePickerController for capturing multiple images in a single session.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

One the limitations of UIImagePickerController is that you can't take multiple pictures in camera without dismissing and relaunching.
This implementation is a custom overlay on UIImagePickerController that lets you capture as many images as you desire.

<!--![](header.png)-->

## Features

- [x] Taking multiple images in a single session
- [x] Delegation pattern
- [x] Customizable

## Requirements

- iOS 9.0+
- Xcode 7.3+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `STCameraPicker` by adding it to your `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!
pod 'STCameraPicker'
```

To get the full benefits import `STCameraPicker` wherever you import UIKit

``` swift
import UIKit
import STCameraPicker
```

<!--## Usage example

```objective-c
#import STCameraPicker
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```-->

## Contribute

We would love for you to contribute to **STCameraPicker**, check the ``LICENSE`` file for more info.

## Meta

Saeed Taheri – [@saeed_taheri](https://twitter.com/saeed_taheri) – saeed.taheri@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/sdtaheri/STCameraPicker](https://github.com/sdtaheri/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
