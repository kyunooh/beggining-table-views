//
//  ViewController.swift
//  Checklist
//
//  Created by jelly on 03/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var todos: TodoList
    var tableData: [[ChecklistItem?]?]!
    
    required init?(coder aDecoder: NSCoder) {
        todos = TodoList()
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
        let sectionTitleCount = UILocalizedIndexedCollation.current().sectionTitles.count
        var allSections = [[ChecklistItem?]?](repeating: nil, count: sectionTitleCount)
        let collation = UILocalizedIndexedCollation.current()
        var sectionNumber = 0
        for item in todos.todos {
            sectionNumber = collation.section(for: item, collationStringSelector: #selector(getter: ChecklistItem.text))
            if allSections[sectionNumber] == nil {
                allSections[sectionNumber] = [ChecklistItem?]()
            }
            
            allSections[sectionNumber]!.append(item)
        }
        tableData = allSections
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todos.move(item: todos.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = todos.todos.count
        _ = todos.newTodo()
        
        let indexPath = IndexPath(row: newRowIndex, section:0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }

    
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [ChecklistItem]()
            for indexPath in selectedRows {
                items.append(todos.todos[indexPath.row])
            }
            todos.remove(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = todos.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let item = todos.todos[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos.todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic
        )
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let checkmarkCell = cell as? ChecklistTableViewCell {
            checkmarkCell.todoTextLabel.text = item.text
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmarkCell = cell as? ChecklistTableViewCell else {
            return
        }
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "√"
        } else {
            checkmarkCell.checkmarkLabel.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todos = todos
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todos.todos[indexPath.row]
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
}


extension ChecklistViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todos.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = todos.todos.firstIndex(of: item) {
            print(index)
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
}
