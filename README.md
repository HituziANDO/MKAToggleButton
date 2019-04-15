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

1. Download latest [MKAToggleButton](https://github.com/HituziANDO/MKAToggleButton/releases)
1. Drag & Drop MKAToggleButton.framework into your Xcode project

## Quick Usage

1. Import the module
	
	**Swift**
	
	```swift
	import MKAToggleButton
	```
	
	**Objective-C**
	
	```objc
	#import <MKAToggleButton/MKAToggleButton.h>
	```

2. Create an instance and set up
	
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
	
	```objc
	// Creates an instance with icon images.
	MKAIconToggleButton *toggleButton = [MKAIconToggleButton toggleButtonWithImages:@[
	    [UIImage imageNamed:@"circle"],
	    [UIImage imageNamed:@"square"],
	    [UIImage imageNamed:@"triangle"],
	    [UIImage imageNamed:@"star"]
	]];
	[self.view addSubview:toggleButton];
	
	// Should use click handler for user interaction.
	toggleButton.clickHandler = ^(id sender) {
	    // `currentStateIndex` property returns the current state.
	    NSLog(@"index=%ld", (long) ((MKAIconToggleButton *) sender).currentStateIndex);
	};
	```
	
	### Or Set up in the Storyboard
	
	1. Set `MKAIconToggleButton` class to Custom Class field in the storyboard
		 
		<img src="./README/setup1.png"/>
		
	2. Set multiple image file names separated by commas to Image Names field
		
		<img src="./README/setup2.png"/>
	
### Template Rendering Mode

When the template mode is enabled, the toggle button applies its tintColor to the icon images.

**Swift**

```swift
// Use the template rendering mode and set a color to `tintColor`.
toggleButton.isImageTemplate = true
toggleButton.tintColor = UIColor(red: 241.0 / 255.0, 
                                 green: 196.0 / 255.0, 
                                 blue: 15.0 / 255.0, 
                                 alpha: 1.0)
```

**Objective-C**

```objc
// Use the template rendering mode and set a color to `tintColor`.
toggleButton.imageTemplate = YES;
toggleButton.tintColor = [UIColor colorWithRed:241.f / 255.f
                                         green:196.f / 255.f
                                          blue:15.f / 255.f
                                         alpha:1.f];
```

----

More info, see my [sample code](https://github.com/HituziANDO/MKAToggleButton/blob/master/Sample/Swift/MKAToggleButtonSwiftSample/ViewController.swift).
