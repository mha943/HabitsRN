//
//  NutritionResultsViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/25/21.
//

import UIKit

class NutritionResultsViewController: UIViewController {
    
    var gender = ""
    var weight = 0.0
    var height = (0, 0)
    var heightCM = 0.0
    var age = 0
    var active = ""
    var other = ""
    
    var bmr: Double = 0.0
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVars()
        // Do any additional setup after loading the view.
        calcCalories()
    }
    
    func setupVars(){
        gender = NutritionAppViewController.gender
        weight = (Double)(NutritionAppViewController.weight)
        height = NutritionAppViewController.height
        age = NutritionAppViewController.age
        active = NutritionAppViewController.active
        other = NutritionAppViewController.other
    }
    func convertToMetric(){
        weight /= 2.20462262185
        heightCM = ((12*(Double)(height.0))+(Double)(height.1))*2.54
    }
    
    func calcBMR() -> Double {
        convertToMetric()
        //Calorie Count based off the MIfflin-St Jeor Equation
        let w = 10 * weight
        let h = 6.25 * heightCM
        let a = (Double)(5 * age)
        
        if(gender == "Male"){
            return (w + h - a + 5)
        }else{
            return (w + h - a - 161)
        }
    }
    
    func calcCalories(){
        bmr = calcBMR().rounded(.up)
        var calories = bmr
        
        switch active {
        case "Sedentary":
            calories *= 1.2
        case "Lightly-Active":
            calories *= 1.375
        case "Moderately-Active":
            calories *= 1.55
        case "Very-Active":
            calories *= 1.725
        case "Extra-Active":
            calories *= 1.9
        default:
            calories *= 1.155
            print("Error, some selection doesn't match in switch")
        }
        
        switch other {
        case "Pregnant":
            calories += 300
        case "Nursing":
            calories += 500
        default:
            calories += 0
        }
        
        totalLabel.text = "\((Int)(calories)) Calories"
        
    }
    
}
