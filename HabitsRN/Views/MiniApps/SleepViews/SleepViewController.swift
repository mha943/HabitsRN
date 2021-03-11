//
//  SleepViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/9/21.
//

import UIKit

class SleepViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggested Sleep Habits"
        // Do any additional setup after loading the view.
    }


    @IBAction func recomendSleepButtonPressed(_ sender: Any) {
        let sleepRecVC = SleepRecommendViewController.instaniate()
        navigationController?.pushViewController(sleepRecVC, animated: true)
    }
    

}
