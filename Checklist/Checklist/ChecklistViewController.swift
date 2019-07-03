//
//  ViewController.swift
//  Checklist
//
//  Created by jelly on 03/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row % 5 == 0 {
                label.text = "Take a jog"
            } else if indexPath.row % 5 == 1 {
                label.text = "Watch a movie"
            } else if indexPath.row % 5 == 2 {
                label.text = "Code an app"
            } else if indexPath.row % 5 == 3 {
                label.text = "Walk the dog"
            } else if indexPath.row % 5 == 4 {
                label.text = "Study design patterns"
            }
        }
        
        return cell
    }
    
}

