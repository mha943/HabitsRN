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
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    // based on slider value, updates labels to display reccommened sleep hours
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
    
}
extension SleepRecommendViewController{
    // sets the title and then adds a done button
    func setupNavBar(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(pressDone(_:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // done button returns to the main page
    @objc func pressDone(_ sender: UIBarButtonItem){
         navigationController?.popToRootViewController(animated: true)
    }
}
