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
}
