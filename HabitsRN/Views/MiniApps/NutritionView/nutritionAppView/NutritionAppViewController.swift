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
    var heightPickerData: [[String]] = [[String]]()
    var activePickerData: [String] = [String]()
    var otherPickerData: [String] = [String]()
    
    var gender: String = "Female"
    var height: (String, String) = ("4", "0")
    var active: String = "Sedentary"
    var other: String = "None"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //connect data to picker
        setupGender()
        setupHeight()
        setupActive()
        setupOther()
    }
    @IBAction func calculateCaloriesButtonPressed(_ sender: Any) {
        // if all valid values then calculate
        //else give alert with pertinent info
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
        
        heightPickerData = [["4", "5", "6", "7"], ["0","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]]
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
            gender = genderPickerData[row]
            print(gender)
        }else if pickerView.tag == 2{
            // this next line from stackoverflow source on 3/23 todo list
            height = (heightPickerData[0][pickerView.selectedRow(inComponent: 0)],heightPickerData[1][pickerView.selectedRow(inComponent: 1)])
            print("\(Int(height.0)!) feet and \(Int(height.1)!) inches")
            
        }else if pickerView.tag == 3{
            active = activePickerData[row]
            print(active)
        }else{
            other = otherPickerData[row]
            print(other)
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
