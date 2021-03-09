//
//  ConfirmHabitViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/8/21.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    @IBOutlet weak var habitImageView: UIImageView!
    @IBOutlet weak var habitNameInputField: UITextField!
    
    
    var habitImage: Habit.Images!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    private func updateUI(){
        title = "New Habit"
        habitImageView.image = habitImage.image
    }


    @IBAction func createHabitButtonPressed(_ sender: Any) {
        // if the text is blank then alerts user
        if habitNameInputField.text == "" || habitNameInputField.text == "Name Of Habit"{
            let alert = UIAlertController(title: "Empty Name", message: "Please enter a name for your Habit", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            // else create a new habit and return to main screen
            var persistenceLayer = PersistenceLayer()
            guard let habitText = habitNameInputField.text else {return}
            persistenceLayer.addHabit(name: habitText, image: habitImage)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    

}
