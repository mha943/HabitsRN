//
//  HabitDetailViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/9/21.
//

import Charts
import UIKit

class HabitDetailViewController: UIViewController, ChartViewDelegate {
    
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
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var pieView: UIStackView!
    
    static var habit2: Habit!
    static var habitIndex2: Int!
    var pieChart = PieChartView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        HabitDetailViewController.habit2 = habit
        HabitDetailViewController.habitIndex2 = habitIndex
        notificationLabel.text = "Reminder"
    }
    override func viewDidLoad() {
        setupPieView()
        setupPieChart()
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
    func setupPieView(){
        pieChart.delegate = self
        pieView.frame = CGRect(x: 0, y: 0, width: self.pieView.frame.width, height: 150)
    }
    
    //Pie Chart code adapted from https://www.youtube.com/watch?v=J9hl7HHXNHU
    func setupPieChart(){
        pieChart.frame = CGRect(x: 0, y: 0, width: self.pieView.frame.size.width, height: self.pieView.frame.size.height)
        pieChart.center = pieView.center
        pieView.addSubview(pieChart)
        
        let labels = ["Current", "Until Best"]
        let streakVals = [habit.currentStreak, habit.bestStreak-habit.currentStreak]
        if streakVals[0] == 0 && streakVals[1] == 0{
            
        }else{
            var entries = [ChartDataEntry]()
            
            for x in 0..<labels.count{
                let dataEntry = PieChartDataEntry(value: Double(streakVals[x]), label: labels[x])
                entries.append(dataEntry)
            }
            
            let set = PieChartDataSet(entries: entries)
            set.label = ""
            set.colors = ChartColorTemplates.material()
            
            let data = PieChartData(dataSet: set)
            
            // Help Code to get rid of decimal points on pie chart: https://stackoverflow.com/questions/44186683/ios-charts-remove-decimal-from-yvalues
            let format = NumberFormatter()
            format.numberStyle = .none
            let formatter = DefaultValueFormatter(formatter: format)
            data.setValueFormatter(formatter)
            // end help code
            
            pieChart.data = data
        }
        
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 15)
        pieChart.data?.setValueFont(UIFont.systemFont(ofSize: 17))
        pieChart.drawHoleEnabled = false
        pieChart.rotationEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        
    }
}
