# OhCrap

An apple crash handler.

## Requirements

* iOS 8.0+
* macOS 10.10+
* watchOS 2.0+
* tvOS 9.0+
* Xcode 8 with Swift 3

## Installation

#### CocoaPods

```ruby
pod 'OhCrap'
```

## Usage

```swift
import OhCrap
```

```swift
OhCrap.isEnable = true
OhCrap.delegate = self // <OhCrapDelegate>
```

```swift
/// <OhCrapDelegate>
func ohCrapDidCatch(_ exception: NSException, forType type: OhCrap.CrashType) {
  // ...
}
```

## Objective-C Version

See [MXCrashHandler-in-Objective-C](https://github.com/Meniny/MXCrashHandler-in-Objective-C).
