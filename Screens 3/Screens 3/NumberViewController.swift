//
//  NumberViewController.swift
//  Screens 3
//
//  Created by Gerardo Hernandez on 12/13/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 80))
   
    //gets called once. Once is initialized and created in memeory
    override func viewDidLoad() { //a good place to configure
        super.viewDidLoad()
        //getting label propertities.
        view.addSubview(label)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        //this updated the x y from label
        label.center = view.center //center label right in center of view.. view is refereing to the view controller
        
    }
    
    //will know for sure the view is already loaded a better place to load your custom
    //viewWillAppear is a swift class
    //reset the number each time the view controller appears
    //gets called multiple times based on where it sits on the navigation. Once you pop back a view it is called again. segue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) //getting the super class from viewWillApper. Animated is being passed from the passed in func
        
        //navigationcontroller has view controller properties. Setting the count of view controllers. navigationctroller is always optional
        if let number = navigationController?.viewControllers.count {
            label.text = String(number)
            
        }
        
        
        
      
    }
    //MARK: - IBActions
   
        // setting the done button tapped through code. method on navigation controller. pops all view controllers but root viwe controller. "Go back to the beginning"
              @IBAction func doneButtonTapped(_ sender: Any) {
                  navigationController?.popToRootViewController(animated: true)
    
    }
    

}
