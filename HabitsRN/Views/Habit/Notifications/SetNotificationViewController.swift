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
    }

    @IBAction func confirmButtonPressed(_ sender: Any) {
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        
        HabitDetailViewController.habit2 = persistence.setNotificationDate(HabitDetailViewController.habitIndex2, hour: hour, min: minute)
        
        navigationController?.popViewController(animated: true)
        }

}


