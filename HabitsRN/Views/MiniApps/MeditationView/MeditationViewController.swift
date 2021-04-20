//
//  MeditationViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/13/21.
//

import UIKit

class MeditationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meditation Habits"
        // Do any additional setup after loading the view.
    }

    @IBAction func breatheButtonPressed(_ sender: Any) {
        let breatheVC = BreatheViewController.instaniate()
        
        navigationController?.pushViewController(breatheVC, animated: true)
    }
    

}
