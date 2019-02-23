MKAToggleButton
===

***MKAToggleButton is multiple icons toggle button for iOS.***

<img src="./README/toggle1.gif"/><img src="./README/toggle2.gif"/><img src="./README/toggle3.gif"/><img src="./README/toggle4.gif"/>

## Include in your iOS app

### CocoaPods

MKAToggleButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKAToggleButton"
```

### Manual Installation

1. Downloads latest [MKAToggleButton](https://github.com/HituziANDO/MKAToggleButton/releases)
1. Drags & Drops MKAToggleButton.framework into your Xcode project

## Quick Usage

1. Imports the module
	
	**Swift**
	
	```swift
	import MKAToggleButton
	```
	
	**Objective-C**
	
	```objc
	#import <MKAToggleButton/MKAToggleButton.h>
	```

2. Creates an instance and sets up
	
	**Swift**
	
	```swift
	// Creates an instance with icon images.
	let toggleButton = MKAIconToggleButton(images: [UIImage(named: "circle")!,
	                                                UIImage(named: "square")!,
	                                                UIImage(named: "triangle")!,
	                                                UIImage(named: "star")!])
	self.view.addSubview(toggleButton)
	
	// Should use click handler for user interaction.
	toggleButton.clickHandler = { sender in
	    if let button = sender as? MKAIconToggleButton {
	        // `currentStateIndex` property returns the current state.
	        print("index=\(button.currentStateIndex)")
	    }
	}
	```
	
	**Objective-C**
	
	TBA
	
	### Or Sets up in the Storyboard
	
	1. Sets `MKAIconToggleButton` class to Custom Class field in the storyboard
		 
		<img src="./README/setup1.png"/>
		
	2. Sets multiple image file names separated by commas to Image Names field
		
		<img src="./README/setup2.png"/>
	
### Template Rendering Mode

When the template mode is enabled, the toggle button applies its tintColor to the icon images.

**Swift**

```swift
// Uses the template rendering mode and sets a color to `tintColor`.
toggleButton.isImageTemplate = true
toggleButton.tintColor = UIColor(red: 241.0 / 255.0, green: 196.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
```

**Objective-C**

TBA

----

More info, see my [sample code](https://github.com/HituziANDO/MKAToggleButton/blob/master/Sample/Swift/MKAToggleButtonSwiftSample/ViewController.swift).
