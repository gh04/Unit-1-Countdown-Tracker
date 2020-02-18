//
//  ViewController.swift
//  ColorPicker
//
//  Created by Gerardo Hernandez on 2/5/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func userPickedColor(_ sender: ColorPicker) {
        view.backgroundColor = sender.color
    }
    
}

