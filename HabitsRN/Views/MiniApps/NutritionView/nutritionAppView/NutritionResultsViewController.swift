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
    var calorieTotal: Double = 0.0
    var carbTotal: Double = 0.0
    var proteinTotal: Double = 0.0
    var fatTotal: Double = 0.0
    
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
        setupPieStack()
        PieSubview()
    }
    
    func setupPieStack(){
        pieChart.delegate = self
        pieStack.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 275)
    }
    
    //Pie Chart code adapted from https://www.youtube.com/watch?v=J9hl7HHXNHU
    func PieSubview() {
        // set the size of chart to fit into view
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.pieStack.frame.size.height,
                                height: self.pieStack.frame.size.height)
        // center the chart and add to pieStack view
        pieChart.center = pieStack.center
        pieStack.addSubview(pieChart)
        
        // set up entry values for the pie chart
        let category = ["Carbs","Fats","Proteins"]
        
        // values from harvard are c = 50% f = 30% p = 20%
        let carbGrams = carbTotal/4
        let fatGrams = fatTotal/9
        let proteinGrams = proteinTotal/4
        
        let values = [carbGrams, fatGrams, proteinGrams]
        
        var entries = [ChartDataEntry]()
        
        // add chart data into entries
        for x in 0..<category.count{
            let dataEntry = PieChartDataEntry(value: Double(values[x]), label: category[x])
            entries.append(dataEntry)
        }
        
        // create a pieChartDataSet from entries
        let set = PieChartDataSet(entries: entries, label: nil)
        
        // set colors
        set.colors = ChartColorTemplates.pastel()
        
        // add the data to the pie chart
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        
        //turn off legend and increase font size of pie chart
        pieChart.legend.enabled = false
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 17)
        pieChart.data?.setValueFont(UIFont.systemFont(ofSize: 20))
        pieChart.drawHoleEnabled = false
        
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
        
        calorieTotal = calories
        carbTotal = calories*0.5
        fatTotal = calories*0.3
        proteinTotal = calories*0.2
        totalLabel.text = "\((Int)(calories)) Calories"
        carbsLabel.text = "\((Int)(carbTotal)) Calories"
        fatsLabel.text = "\((Int)(fatTotal)) Calories"
        proteinLabel.text = "\((Int)(proteinTotal)) Calories"
        
    }
    
}
