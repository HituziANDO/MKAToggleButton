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

    private var        button1: MKAIconToggleButton!
    // `button2` is created from the storyboard.
    // Icon image files are specified by strings represented comma separator in Image Names field.
    @IBOutlet weak var button2: MKAIconToggleButton!
    private var        button3: MKAIconToggleButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Creates an instance with icon images.
        self.button1 = MKAIconToggleButton(images: [UIImage(named: "circle")!,
                                                    UIImage(named: "square")!,
                                                    UIImage(named: "triangle")!,
                                                    UIImage(named: "star")!])
        self.view.addSubview(self.button1)

        // Should use click handler for user interaction.
        self.button1.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                // `currentStateIndex` property returns the current state.
                print("[1] index=\(button.currentStateIndex)")
            }
        }

        self.button2.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[2] index=\(button.currentStateIndex)")
            }
        }

        // Changes the current state.
        self.button2.currentStateIndex = 1

        self.button3 = MKAIconToggleButton(images: [UIImage(named: "unstarred")!,
                                                    UIImage(named: "starred")!])
        self.view.addSubview(self.button3)

        // Uses the template rendering mode and sets a color to `tintColor`.
        self.button3.isImageTemplate = true
        self.button3.tintColor = UIColor(red: 241.0 / 255.0, green: 196.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)

        self.button3.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[3] index=\(button.currentStateIndex)")
            }
        }

        // Goes to next state. If the current state is last index, next state will be first index.
        self.button3.nextState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.button1.center = CGPoint(x: self.button2.center.x, y: self.button2.center.y - 160.0)
        self.button3.center = CGPoint(x: self.button1.center.x, y: self.button1.center.y - 160.0)
    }
}
