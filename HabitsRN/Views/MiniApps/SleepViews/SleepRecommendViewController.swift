//
//  SleepRecommendViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/10/21.
//

import UIKit

class SleepRecommendViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var recommendLabel: UILabel!
    
    @IBOutlet weak var dialoglabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialoglabel.text = " \n"
        recommendLabel.text = " "
        slider.value = 30
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        dialoglabel.text = "Your Recommended Sleep is:"
        var recValue = ""
        let sValue = Int(slider.value)
        ageLabel.text = String("Age: \(sValue)")
        switch sValue{
            case 0:  recValue = "12-15"
            case 1...2:  recValue = "11-14"
            case 3...5:  recValue = "10-13"
            case 6...13:  recValue = "9-11"
            case 14...17:  recValue = "8-10"
            case 18...25:  recValue = "7-9"
            case 26...64:  recValue = "7-9"
            case 65...99:  recValue = "7-8"
            case _: recValue = "7-8"
        }
        recommendLabel.text = String("\(recValue) Hours")
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
