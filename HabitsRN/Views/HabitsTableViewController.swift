//
//  MainViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/26/21.
//

import UIKit

class HabitsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Return the number of rows for the given section
    override func tableView(_ tabelView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count
        
    }
    
    // Return the UITableViewCell for the given indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell: UITableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            cell = dequeueCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let name = names[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }

    
    //test array
    var names: [String] = ["Alan", "Braus", "Max", "Libby", "Matthew"]
}
