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
        setupNavBar()
    }

    // navigates to next page
    @IBAction func recomendSleepButtonPressed(_ sender: Any) {
        let sleepRecVC = SleepRecommendViewController.instaniate()
        navigationController?.pushViewController(sleepRecVC, animated: true)
    }
    
}

extension SleepViewController{
    
    func setupNavBar(){
        title = "Suggested Sleep Habits"

    }
    
}
