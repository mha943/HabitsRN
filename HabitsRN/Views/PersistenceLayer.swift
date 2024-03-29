//
//  PersistenceLayer.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/5/21.
//

import Foundation

struct PersistenceLayer{
    
    // setter variable for array of habits
    private(set) var habits: [Habit] = []
    
    // key to access userdefault array of habits
    private static let userDefaultHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    // mutating so that it will change the values passed to it.
    private mutating func loadHabits(){
        
        // create userDefaults
        let userDefaults = UserDefaults.standard
        
        // load the habits from the userDefaults database and place it into array
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else{
            return
        }
        self.habits = habits
    }
    
    
    @discardableResult
    // function to add habit and preappend it to the begining of Habit array
    mutating func addHabit(name: String, image: Habit.Images) -> Habit{
        
        let newHabit = Habit(title: name, image: image)
        self.habits.insert(newHabit, at: 0)
        self.saveHabits()
        
        return newHabit
    }
    
    private func saveHabits(){
        // encode the habit into the userDefault database
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("Couldn't encode the list of Habits")
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultHabitsKeyValue)
        userDefaults.synchronize()
    }
    
    mutating func delete(_ habitIndex: Int){
        //delete the old notifiction
        habits[habitIndex].deleteNotification()
        // remove the habit from the indicated index
        self.habits.remove(at: habitIndex)
        self.saveHabits()
    }
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit{
        var updatedHabit = self.habits[habitIndex]
        guard updatedHabit.completedToday == false else { return updatedHabit}
        
        updatedHabit.numberOfCompletions += 1
        
        // set up streak variable for the habit
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        }else{
            updatedHabit.currentStreak = 1
        }
        
        // if the current streak is better than best then set best
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        // sets last completion to today
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        // place the habit back into the array
        self.habits[habitIndex] = updatedHabit
        
        self.saveHabits()
        
        return updatedHabit
    }
    
    // given a index and destination index the destination
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int){
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
        
    }
    
    mutating func setNeedsToReloadHabits(){
        self.loadHabits()
    }
    
    // set the notification boolean of the habit and save it back into persistance.
    mutating func setNotificationHabit(_ habitIndex: Int) -> Habit{
        var updatedHabit = self.habits[habitIndex]

        updatedHabit.notificationBool = !updatedHabit.notificationBool

        // place the habit back into the array
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()

        return updatedHabit
    }
    
    // sets a date for a notification and saves it in persistance.
    mutating func setNotificationDate(_ habitIndex: Int, hour: Int, min: Int) -> Habit{
        var updatedHabit = self.habits[habitIndex]

        updatedHabit.notifyHour = hour
        updatedHabit.notifyMinute = min
        updatedHabit.setNotification()
        // place the habit back into the array
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
    
        return updatedHabit
    }
    
    // deletest the notification when habit is deleted.
    mutating func unsetNotification(_ habitIndex: Int) -> Habit{
        let updatedHabit = self.habits[habitIndex]
        //delete the old notifiction
        updatedHabit.deleteNotification()
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
    
        return updatedHabit
    }
}
