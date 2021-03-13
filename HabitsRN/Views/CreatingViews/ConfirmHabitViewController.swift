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
    
    @IBOutlet weak var createHabitButton: UIButton!
    
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
    
    // From https://www.codingexplorer.com/how-to-dismiss-uitextfields-keyboard-in-your-swift-app/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    
    // Adapted from https://medium.com/@PaulWall43/how-to-raise-a-uitextfield-when-the-keyboard-shows-ccfa6553c911
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adds observers to notificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(ConfirmHabitViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConfirmHabitViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= (keyboardFrame.height)/1.25
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }

}
