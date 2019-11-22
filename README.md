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
	
2. Create an instance and set up
	
	**Swift**
	
	```swift
	private lazy var toggleButton: MKAIconToggleButton = {
        // Creates an instance with options.
        let button = MKAIconToggleButton(items: [MKAToggleItem(image: UIImage(named: "circle"), title: "Circle"),
                                                 MKAToggleItem(image: UIImage(named: "square"), title: "Square"),
                                                 MKAToggleItem(image: UIImage(named: "triangle"), title: "Triangle"),
                                                 MKAToggleItem(image: UIImage(named: "star"), title: "Start")],
                                         font: UIFont.systemFont(ofSize: 40.0, weight: .bold),
                                         color: .gray)

        // Should use click handler for user interaction.
        button.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                // `currentStateIndex` property returns the current state.
                // The toggle button automatically increments the state each time it is clicked.
                // When the current state is last, the next state is rewinded to the first.
                print("index=\(button.currentStateIndex)")
            }
        }

        // Sets the initial state. By default, the initial state index is zero.
        button.currentStateIndex = 1

        return button
    }()
	```
	
1. Add the toggle button to a parent view
	
	**Swift**
	
	```swift
	override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.toggleButton)
   }
	```
	
## Use the toggle button in the storyboard
	
1. Set `MKAIconToggleButton` class to Custom Class field in the storyboard
	
	<img src="./README/setup1.png"/>
	
2. Set multiple image file names separated by commas to Image Names field
	
	<img src="./README/setup2.png"/>
	
## Template Rendering Mode

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

----

More info, see my [sample code](https://github.com/HituziANDO/MKAToggleButton/blob/master/Sample/Swift/MKAToggleButtonSwiftSample/ViewController.swift).
