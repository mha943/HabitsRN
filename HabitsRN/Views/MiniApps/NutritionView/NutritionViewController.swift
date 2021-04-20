//
//  NutritionViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/13/21.
//

import UIKit

class NutritionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suggested Nutrition"
        // Do any additional setup after loading the view.
    }
    @IBAction func nutritionButtonPressed(_ sender: Any) {
        let nutritionAppVC = NutritionAppViewController.instaniate()
        
        navigationController?.pushViewController(nutritionAppVC, animated: true)
    }

}
