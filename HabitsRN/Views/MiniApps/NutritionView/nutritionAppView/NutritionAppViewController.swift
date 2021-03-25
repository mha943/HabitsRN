//
//  NutritionAppViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/22/21.
//  Learned how to make UIPickerView from codewithchris source from 3/23
//

import UIKit


class NutritionAppViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var activePicker: UIPickerView!
    @IBOutlet weak var otherPicker: UIPickerView!
    
    @IBOutlet weak var weightTextbox: UITextField!
    @IBOutlet weak var ageTextbox: UITextField!
    
    var genderPickerData: [String] = [String]()
    var heightPickerData: [[Int]] = [[Int]]()
    var activePickerData: [String] = [String]()
    var otherPickerData: [String] = [String]()
    
    static var gender: String = "Female"
    static var height: (Int, Int) = (4, 0)
    static var active: String = "Sedentary"
    static var other: String = "None"
    static var weight: Int = 150
    static var age: Int = 30
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //connect data to picker
        setupGender()
        setupHeight()
        setupActive()
        setupOther()
    }
    @IBAction func calculateCaloriesButtonPressed(_ sender: Any) {
        // if all valid values then calculate
        let weightRange = 50...350
        let ageRange = 10...90
        var valid = true
        
        if(weightTextbox.hasText && ageTextbox.hasText){
            if(weightRange.contains((Int)(weightTextbox.text!)!) && ageRange.contains((Int)(ageTextbox.text!)!)){
            }else{
                valid = false
            }
        }else{
            valid = false
        }
        
        if(valid){
            NutritionAppViewController.weight = (Int)(weightTextbox.text!)!
            NutritionAppViewController.age = (Int)(ageTextbox.text!)!
            //print("\(NutritionAppViewController.weight)\n\(NutritionAppViewController.age)")
            // open to new page
            let nutritionResultsVC = NutritionResultsViewController.instaniate()
            navigationController?.pushViewController(nutritionResultsVC, animated: true)
            
        }else{//else give alert with pertinent info
            let inputAlert = UIAlertController(title: "Invalid Inputs", message: "Weight must be in range (50-350)\nAge must be in range (10-90)", preferredStyle: .alert)
                   inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(inputAlert, animated: true)
        }
       
        
    }
    
    // From https://www.codingexplorer.com/how-to-dismiss-uitextfields-keyboard-in-your-swift-app/
    // dismisses keyboard when you touch outside of it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupGender(){
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        // input data into gender array
        genderPickerData = ["Female", "Male"]
    }
    
    func setupHeight(){
        self.heightPicker.delegate = self
        self.heightPicker.dataSource = self
        
        heightPickerData = [[4, 5, 6, 7], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]]
    }
    
    func setupActive(){
        self.activePicker.delegate = self
        self.activePicker.dataSource = self
        
        activePickerData = ["Sedentary", "Lightly-Active", "Moderately-Active", "Very-Active", "Extra-Active"]
    }
    
    func setupOther(){
        self.otherPicker.delegate = self
        self.otherPicker.dataSource = self
        
        otherPickerData = ["None", "Pregnant", "Nursing"]
    }
    // number of Columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 2{
            return 2
        }else{
            return 1
        }
        
    }
    // number of Rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return genderPickerData.count
        }else if pickerView.tag == 2{
            return heightPickerData[component].count
        }else if pickerView.tag == 3{
            return activePickerData.count
        }else{
            return otherPickerData.count
        }
    }
    
    // display the selected value from picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView.tag == 1{
            return genderPickerData[row]
        }else if pickerView.tag == 2{
            if component == 0{
                return "\(heightPickerData[component][row]) foot"
            }else{
                return "\(heightPickerData[component][row]) inches"
            }
            
        }else if pickerView.tag == 3{
            return activePickerData[row]
        }else{
            return otherPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            NutritionAppViewController.gender = genderPickerData[row]
            //print(NutritionAppViewController.gender)
        }else if pickerView.tag == 2{
            // this next line from stackoverflow source on 3/23 todo list
            NutritionAppViewController.height = (heightPickerData[0][pickerView.selectedRow(inComponent: 0)],heightPickerData[1][pickerView.selectedRow(inComponent: 1)])
            //print("\((NutritionAppViewController.height.0)) feet and \((NutritionAppViewController.height.1)) inches")
            
        }else if pickerView.tag == 3{
            NutritionAppViewController.active = activePickerData[row]
            //print(NutritionAppViewController.active)
        }else{
            NutritionAppViewController.other = otherPickerData[row]
            //print(NutritionAppViewController.other)
        }
        
        
        
        
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
