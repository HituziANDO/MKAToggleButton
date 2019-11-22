//
//  ViewController.swift
//  MKAToggleButtonSwiftSample
//
//  Created by Masaki Ando on 2019/02/13.
//  Copyright © 2019年 Hituzi Ando. All rights reserved.
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

        // Should use click handler for user interaction.
        button.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                // `currentStateIndex` property returns the current state.
                // The toggle button automatically increments the state each time it is clicked.
                // When the current state is last, the next state is rewinded to the first.
                print("[1] index=\(button.currentStateIndex)")
            }
        }

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

        button.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[3] index=\(button.currentStateIndex)")
            }
        }

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
        button.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[4] index=\(button.currentStateIndex)")
            }
        }
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
        button.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[5] index=\(button.currentStateIndex)")
            }
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.button1)
        self.view.addSubview(self.button3)
        self.view.addSubview(self.button4)
        self.view.addSubview(self.button5)

        self.button2.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[2] index=\(button.currentStateIndex)")
            }
        }

        // Moves to next state manually.
        // When the current state is last, the next state is rewinded to the first.
        self.button3.nextState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.button1.center = CGPoint(x: self.button2.center.x, y: self.button2.center.y - 100.0)
        self.button3.center = CGPoint(x: self.button1.center.x, y: self.button1.center.y - 100.0)
        self.button4.center = CGPoint(x: self.button3.center.x, y: self.button3.center.y - 100.0)
        self.button5.center = CGPoint(x: self.button4.center.x, y: self.button4.center.y - 100.0)
    }
}
