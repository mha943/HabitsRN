//
//  NutritionResultsViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/25/21.
//
import Charts
import UIKit

class NutritionResultsViewController: UIViewController, ChartViewDelegate {
    
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
    @IBOutlet weak var pieStack: UIStackView!
    
    var pieChart = PieChartView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVars()
        // Do any additional setup after loading the view.
        calcCalories()
        pieChart.delegate = self
        pieStack.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3)
    }
    
    //Pie Chart code https://www.youtube.com/watch?v=J9hl7HHXNHU
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.pieStack.frame.size.height,
                                height: self.pieStack.frame.size.height)
        pieChart.center = pieStack.center
        //view.addSubview(pieChart)
        pieStack.addSubview(pieChart)
        
        let category = ["Protein", "Carbs", "Fats"]
        let values = [5, 20, 17]
        var entries = [ChartDataEntry]()
        
        for x in 0..<category.count{
            let dataEntry = PieChartDataEntry(value: Double(values[x]), label: category[x])
            entries.append(dataEntry)
        }
        
        let set = PieChartDataSet(entries: entries, label: nil)
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.legend.enabled = false
        
        
        
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
