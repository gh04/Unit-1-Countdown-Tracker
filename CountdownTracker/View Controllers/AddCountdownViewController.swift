//
//  AddCountdownViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class AddCountdownViewController: UIViewController {

    //MARK: Properties

    var countdownController: CountdownController?
    
    //MARK: - IBOutlets

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var tagNameTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    //MARK: - IBActions

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddCountdownViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
