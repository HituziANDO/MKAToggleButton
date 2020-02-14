//
//  ViewController.swift
//  MKAToggleButtonSwiftSample
//
//  Copyright © 2020 Hituzi Ando. All rights reserved.
//

import UIKit
import MKAToggleButton

class ViewController: UIViewController {

    private lazy var button1: MKAIconToggleButton = {
        // Creates an instance with icon images.
        let button = MKAIconToggleButton(items: [MKAToggleItem(image: UIImage(named: "circle")!),
                                                 MKAToggleItem(image: UIImage(named: "square")!),
                                                 MKAToggleItem(image: UIImage(named: "triangle")!),
                                                 MKAToggleItem(image: UIImage(named: "star")!)])

        // Should use the click handler for user interaction.
        button.onClicked = { button in
            // `currentStateIndex` property returns the current state.
            // The toggle button automatically increments the state each time it is clicked.
            // When the current state is last, the next state is rewinded to the first.
            print("[1] index=\(button.currentStateIndex)")
        }

        // You can set the event handler that handle the long press event.
        button.longPressGesture.minimumPressDuration = 1.0
        button.onLongPressBegan = { print("[1] longPressBegan index=\($0.currentStateIndex)") }
        button.onLongPressChanged = { print("[1] longPressChanged index=\($0.currentStateIndex)") }
        button.onLongPressEnded = { print("[1] longPressEnded index=\($0.currentStateIndex)") }
        button.onLongPressCancelled = { print("[1] longPressCancelled index=\($0.currentStateIndex)") }

        // You can extend touchable area.
        button.touchableExtensionTop = 16.0
        button.touchableExtensionLeft = 40.0
        button.touchableExtensionBottom = 16.0
        button.touchableExtensionRight = 40.0

        // Sets the initial state. By default, the initial state index is zero.
        button.currentStateIndex = 1

        return button
    }()

    // `button2` is created from the storyboard.
    // Icon image files are specified by strings represented comma separator in Image Names field.
    @IBOutlet weak var button2: MKAIconToggleButton!

    private lazy var button3: MKAIconToggleButton = {
        let button = MKAIconToggleButton(items: [MKAToggleItem(image: UIImage(named: "unstarred")!),
                                                 MKAToggleItem(image: UIImage(named: "starred")!)])

        // Uses the template rendering mode and sets a color to `tintColor`.
        button.isImageTemplate = true
        button.tintColor = UIColor(red: 241.0 / 255.0, green: 196.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)

        button.onClicked = { print("[3] index=\($0.currentStateIndex)") }

        return button
    }()

    private lazy var button4: MKAIconToggleButton = {
        // Creates an instance with sets of a title and an icon image.
        let button = MKAIconToggleButton(items: [MKAToggleItem(image: UIImage(named: "circle"), title: "Circle"),
                                                 MKAToggleItem(image: UIImage(named: "square"), title: "Square"),
                                                 MKAToggleItem(image: UIImage(named: "triangle"), title: "Triangle"),
                                                 MKAToggleItem(image: UIImage(named: "star"), title: "Start")],
                                         font: UIFont.systemFont(ofSize: 40.0, weight: .bold),
                                         color: .gray)
        button.onClicked = { print("[4] index=\($0.currentStateIndex)") }
        return button
    }()

    private lazy var button5: MKAIconToggleButton = {
        // Creates an instance with titles.
        let button = MKAIconToggleButton(items: [MKAToggleItem(title: "Circle"),
                                                 MKAToggleItem(title: "Square"),
                                                 MKAToggleItem(title: "Triangle"),
                                                 MKAToggleItem(title: "Star")],
                                         font: UIFont.systemFont(ofSize: 24.0),
                                         color: UIColor(red: 52.0 / 255.0, green: 152.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0))
        button.layer.borderWidth = 1.0
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.cornerRadius = 4.0
        button.onClicked = { print("[5] index=\($0.currentStateIndex)") }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.button1)
        self.view.addSubview(self.button3)
        self.view.addSubview(self.button4)
        self.view.addSubview(self.button5)

        self.button2.onClicked = { print("[2] index=\($0.currentStateIndex)") }

        // Moves to next state manually.
        // When the current state is last, the next state is rewinded to the first.
        self.button4.nextState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.button1.center = CGPoint(x: self.button2.center.x, y: self.button2.center.y - 100.0)
        self.button3.center = CGPoint(x: self.button1.center.x, y: self.button1.center.y - 100.0)
        self.button4.center = CGPoint(x: self.button3.center.x, y: self.button3.center.y - 100.0)
        self.button5.center = CGPoint(x: self.button4.center.x, y: self.button4.center.y - 100.0)
    }
}
