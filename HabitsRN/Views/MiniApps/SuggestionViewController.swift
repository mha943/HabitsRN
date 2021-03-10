//
//  SuggestionViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/9/21.
//

import UIKit

class SuggestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggestions"
        // Do any additional setup after loading the view.
    }

    @IBAction func sleepButtonPressed(_ sender: Any) {
        let sleepVC = SleepViewController.instaniate()
        
        navigationController?.pushViewController(sleepVC, animated: true)
    }
    
    

}
