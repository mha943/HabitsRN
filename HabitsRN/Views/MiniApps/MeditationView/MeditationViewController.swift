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
        title = "Meditation"
        // Do any additional setup after loading the view.
    }

    @IBAction func breatheButtonPressed(_ sender: Any) {
        let breatheVC = BreatheViewController.instaniate()
        
        navigationController?.pushViewController(breatheVC, animated: true)
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
