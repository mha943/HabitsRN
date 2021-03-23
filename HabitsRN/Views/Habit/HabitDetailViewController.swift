//
//  HabitDetailViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/9/21.
//

import UIKit

class HabitDetailViewController: UIViewController {

    var habit: Habit!
    var habitIndex: Int!
    
    private var persistence = PersistenceLayer()
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelCurrentStreak: UILabel!
    @IBOutlet weak var labelTotalCompletions: UILabel!
    @IBOutlet weak var labelBestStreak: UILabel!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var notificationTime: UILabel!
    
    static var habit2: Habit!
    static var habitIndex2: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        HabitDetailViewController.habit2 = habit
        HabitDetailViewController.habitIndex2 = habitIndex
        notificationTime.text = "Reminder"
    }
    
    // marks the habit as completed and then updates the UI
    @IBAction func pressActionButton(_ sender: Any) {
        habit = persistence.markHabitAsCompleted(habitIndex)
        updateUI()
    }
    @IBAction func notificationSwitchRelease(_ sender: Any) {
        
        habit = persistence.setNotificationHabit(habitIndex)
        habit.notificationBool = notificationSwitch.isOn

        if habit.notificationBool == true{
            let setNotifyVC = SetNotificationViewController.instaniate()
            navigationController?.pushViewController(setNotifyVC, animated: true)
        }else{
            habit = persistence.unsetNotification(habitIndex)
        }
        
    }
    
    private func updateUI(){
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        labelCurrentStreak.text = "\(habit.currentStreak) days"
        labelTotalCompletions.text = String(habit.numberOfCompletions)
        labelBestStreak.text = String(habit.bestStreak)
        labelStartingDate.text = habit.dateCreated.stringValue
        
        //habit.notificationBool = notificationSwitch.isOn
        
        if habit.notificationBool{
            notificationSwitch.setOn(true, animated: false)
        }else{
            notificationSwitch.setOn(false, animated: false)
        }
        
        if habit.completedToday{
            buttonAction.setTitle("Completed Today!", for: .normal)
        } else{
            buttonAction.setTitle("Mark As Complete", for: .normal)
        }
    }
    
}
