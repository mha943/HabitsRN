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

        // Do any additional setup after loading the view.
    }
    @IBAction func nutritionButtonPressed(_ sender: Any) {
        let nutritionAppVC = NutritionAppViewController.instaniate()
        
        navigationController?.pushViewController(nutritionAppVC, animated: true)
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
