//
//  Habit.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/27/21.
//
//  Habit Struct to hold Habit information

import UIKit

struct Habit : Codable{
    
    enum Images: Int,Codable, CaseIterable {
        case book
        case bulb
        case clock
        case code
        case drop
        case food
        case grow
        case gym
        case heart
        case lotus
        case other
        case pill
        case search
        case sleep
        case tooth
        
        var image: UIImage {
            guard let image = UIImage(named: String(describing: self)) else {
                fatalError("image \(self) not found")
            }
            return image
        }
    }
    
    var title: String
    var dateCreated: Date = Date()
    var selectedImage: Habit.Images
    var currentStreak: Int = 0
    var bestStreak: Int = 0
    var lastCompletionDate: Date?
    var numberOfCompletions: Int = 0
    var notificationBool: Bool = false
    var notifyHour: Int = 0
    var notifyMinute: Int = 0
    
    //checks if completed, if nil then returns false
    var completedToday: Bool {
        return lastCompletionDate?.isToday ?? false
    }
    
    init(title: String, image: Habit.Images){
        self.title = title
        self.selectedImage = image
    }
    
    func setNotification(){
        
       //Link Describing how to set a local notification https://www.donnywals.com/scheduling-daily-notifications-on-ios-using-calendar-and-datecomponents/
        var dateComponents = DateComponents()
        dateComponents.hour = notifyHour
        dateComponents.minute = notifyMinute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "\(title)"
        
        let randomIdentifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){ error in
            if error != nil {
                print("Failed Notification")
            }
            
        }
    }
}
