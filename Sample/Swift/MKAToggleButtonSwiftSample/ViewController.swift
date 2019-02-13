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
    @IBOutlet weak var button2: MKAIconToggleButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.button1 = MKAIconToggleButton(images: [UIImage(named: "circle")!,
                                                    UIImage(named: "square")!,
                                                    UIImage(named: "triangle")!,
                                                    UIImage(named: "star")!])
        self.view.addSubview(self.button1)
        self.button1.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[1] index=\(button.selectedIndex)")
            }
        }

        self.button2.tintColor = UIColor.blue
        self.button2.selectedIndex = 1
        self.button2.clickHandler = { sender in
            if let button = sender as? MKAIconToggleButton {
                print("[2] index=\(button.selectedIndex)")
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.button1.center = CGPoint(x: self.button2.center.x, y: self.button2.center.y - 100.0)
    }
}
