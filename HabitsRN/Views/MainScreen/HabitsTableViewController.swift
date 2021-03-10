//
//  MainViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/26/21.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    //test array
    //    var names: [String] = ["Alan", "Braus", "Max", "Libby", "Matthew"]
    //    //test habits
    //    var habits: [Habit] = [
    //        Habit(title: "go to bed before 10pm", image: Habit.Images.book),
    //        Habit(title: "exercise period, cuz i don't want to get fat",image: Habit.Images.book),
    //        Habit(title: "work on capstone project", image: Habit.Images.book),
    //    ]
    
    private var persistence = PersistenceLayer()
    
    // Return the number of rows for the given section
    override func tableView(_ tabelView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return persistence.habits.count
        
    }
    
    // Return the UITableViewCell for the given indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell( withIdentifier: HabitTableViewCell.identifier,for: indexPath) as! HabitTableViewCell
        let habit = persistence.habits[indexPath.row]
        cell.configure(habit)
        return cell
    }
    
    // Calls the reload function from the persistence layer and reloads the table with it
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.register(
            HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    // method to call the habitDetailView when selecting a habit row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHabit = persistence.habits[indexPath.row]
        let habitDetailVC = HabitDetailViewController.instaniate()
        habitDetailVC.habit = selectedHabit
        habitDetailVC.habitIndex = indexPath.row
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }
    
    // method to delete habit entries
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        switch editingStyle {
        case .delete:
            let habitToDelete = persistence.habits[indexPath.row]
            let habitIndextoDelete = indexPath.row
            
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title){
                self.persistence.delete(habitIndextoDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    
    // method used to call swap of habits
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        persistence.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
}

extension HabitsTableViewController {
    //adds a title, add button to the main view
    func setupNavBar(){
        title = "HabitsRN"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    //when the add button pressed it opens new view
    @objc func pressAddHabit(_ sender: UIBarButtonItem){
        // creates add habit view
        let addHabitVC = AddHabitViewController.instaniate()
        // creates a navigation controller
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        // format the controller
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
}

extension UIAlertController {
    convenience init (habitTitle: String, confirmHandler: @escaping () -> Void){
        self.init(title: "Delete Habit", message:"Are you sure you want to delete \(habitTitle)?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title:"Confirm", style: .destructive){
            _ in confirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
        
    }
}
