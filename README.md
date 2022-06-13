# PreselectedPhotoUI
Use `PreselectedPhotoViewController` to handle limited photo access case in your app.

## Overview

### Supports

- iOS 14.0 or later

### How to use?

> **IMPORTANT**
>
> Don't forget to add `Privacy - Photo Library Usage Description` to `info.plist`

```swift
let vc = PreselectedPhotoViewController()
vc.delegate = self
let nav = UINavigationController(rootViewController: vc)

present(nav, animated: true, completion: nil)
```

1. Conform to `PreselectedPhotoViewDelegate`.

```swift
// ViewController.swift
class ViewController: UIViewController, PreselectedPhotoViewDelegate { 
    func didTapSendImageData(_ data: Data) {
        // process image data
    }
    
    func didTapSendVideoURL(_ url: URL) {
        // process video url
    }
}
```

2. Ready to show `PreselectedPhotoViewController`

```swift
// ViewController.swift
func showLimitedPhotoLibraryPicker() {
    PreselectedPhotoViewController.StringSet.viewLibrary = "{your_own_title}"
    let selectablePhotoVC = PreselectedPhotoViewController()
    selectablePhotoVC.delegate = self
    let nav = UINavigationController(rootViewController: selectablePhotoVC)
    self.present(nav, animated: true, completion: nil)
}
```

3. Connect `showLimitedPhotoLibraryPicker()` method to your button action

```swift
// ViewController.swift
@IBAction func didTapPhotoSelection() {
    showLimitedPhotoLibraryPicker()
}
```
