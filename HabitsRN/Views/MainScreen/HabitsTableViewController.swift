//
//  MainViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/26/21.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    //test array
    var names: [String] = ["Alan", "Braus", "Max", "Libby", "Matthew"]
    //test habits
    var habits: [Habit] = [
        Habit(title: "go to bed before 10pm", image: Habit.Images.book),
        Habit(title: "exercise period, cuz i don't want to get fat",image: Habit.Images.book),
        Habit(title: "work on capstone project", image: Habit.Images.book),
    ]
    
    // Return the number of rows for the given section
    override func tableView(_ tabelView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return habits.count
        
    }
    
    // Return the UITableViewCell for the given indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell( withIdentifier: HabitTableViewCell.identifier,for: indexPath) as! HabitTableViewCell
        let habit = habits[indexPath.row]
        cell.configure(habit)
        return cell
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.register(
            HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
}

extension HabitsTableViewController {
    //adds a title, add button to the main view
    func setupNavBar(){
        title = "HabitsRN"
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
       // navigationItem.rightBarButtonItem = addButton
    }
    
    //when the add button pressed then inserts a new row
//    @objc func pressAddHabit(_ sender: UIBarButtonItem){
//        names.insert("Hello, World!", at: 0)
//        let topIndexPath = IndexPath(row:0, section: 0)
//        tableView.insertRows(at: [topIndexPath], with: .automatic)
//    }
}
