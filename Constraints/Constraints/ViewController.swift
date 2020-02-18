//
//  ViewController.swift
//  Constraints
//
//  Created by Gerardo Hernandez on 1/28/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setupSubViews() {
        let greenView = UIView()
        greenView.backgroundColor = .green
        
       //lets us create the view. Make sure it is set up every time
        greenView.translatesAutoresizingMaskIntoConstraints = false
        //make sure you add subview before you add constraints
        //adding subview
        view.addSubview(greenView)
        
        
        
        //leading edge is equal to safe area of view
        //
        
//        let leadingConstraint = NSLayoutConstraint(item: greenView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 40)
        
        let leadingConstraint = greenView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        //greenView.leading = 1 * view.sa.leading + 40
        
    
        
        
//        let centerYConstraint = NSLayoutConstraint(item: greenView, attribute: .centerY, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: 0)
        
        let centerYConstraint = greenView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        //optional second item
        //still need to give an attribute to an optional
//        let heightConstraint = NSLayoutConstraint(item: greenView, attribute: .height, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: 128)
        
        let heightConstraint = greenView.heightAnchor.constraint(equalToConstant: 128)
        
//        let widthConstraint = NSLayoutConstraint(item: greenView, attribute: .width, relatedBy: .equal, toItem: greenView, attribute: .height, multiplier: 2, constant: 0)
        
        let widthConstraint = greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 2)
        
        NSLayoutConstraint.activate([
        leadingConstraint,
        centerYConstraint,
        heightConstraint,
        widthConstraint
        
        ])
    }

}

