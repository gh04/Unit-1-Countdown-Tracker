//
//  ViewController.swift
//  Networking Sprint
//
//  Created by Gerardo Hernandez on 2/7/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenView.backgroundColor = .black
        
    
        // Do any additional setup after loading the view.
    }

    private func addSubViews() {
        let constraints = NSLayoutConstraint(item: greenView, attribute: <#T##NSLayoutConstraint.Attribute#>, relatedBy: <#T##NSLayoutConstraint.Relation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
    }

    

}

