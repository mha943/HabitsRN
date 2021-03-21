//
//  SetNotificationViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/18/21.
//

import UIKit

class SetNotificationViewController: UIViewController {
    
    
    private var persistence = PersistenceLayer()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Set Notification"
        setupNavBar()
    }

    @IBAction func confirmButtonPressed(_ sender: Any) {
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        print("\(hour)  \(minute)")
        
        HabitDetailViewController.habit2 = persistence.setNotificationDate(HabitDetailViewController.habitIndex2, hour: hour, min: minute)
        
        navigationController?.popViewController(animated: true)
        }

}
extension SetNotificationViewController{
    // sets the title and then adds a done button
    func setupNavBar(){
        // Do any additional setup after loading the view.
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(pressCancel(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // done button returns to the main page
    @objc func pressCancel(_ sender: UIBarButtonItem){
         navigationController?.popViewController(animated: true)
        
        HabitDetailViewController.habit2 = persistence.unsetNotification(HabitDetailViewController.habitIndex2)
        // turn off switch somehow
    }
}


