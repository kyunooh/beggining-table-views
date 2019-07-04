//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by jelly on 04/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func done(_ sender: Any) {
                navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


}
