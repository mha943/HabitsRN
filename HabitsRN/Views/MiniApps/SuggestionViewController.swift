//
//  SuggestionViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/9/21.
//

import UIKit

class SuggestionViewController: UIViewController {

    @IBOutlet weak var sleepButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggestions"
        // Do any additional setup after loading the view.
        //sleepButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }

    
    
    @IBAction func sleepButtonPressed(_ sender: Any) {
        let sleepVC = SleepViewController.instaniate()
        
        navigationController?.pushViewController(sleepVC, animated: true)
    }
    
    @IBAction func meditationButtonPressed(_ sender: Any) {
        let meditationVC = MeditationViewController.instaniate()
        navigationController?.pushViewController(meditationVC, animated: true)
        
    }
    
    @IBAction func nutritionButtonPressed(_ sender: Any) {
        let nutritionVC = NutritionViewController.instaniate()
        navigationController?.pushViewController(nutritionVC, animated: true)
    }
    
    

}
