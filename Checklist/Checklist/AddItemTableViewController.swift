//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by jelly on 04/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    weak var todos: TodoList?
    weak var itemToEdit: ChecklistItem?
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)  
    }
    @IBAction func done(_ sender: Any) {
        print(itemToEdit)
        if let item = itemToEdit, let text = textField.text {
            print(item)
            item.text = text
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            if let item = todos?.newTodo() {
                if let textFieldText = textField.text {
                    item.text = textFieldText
                }
                item.checked = false
                delegate?.addItemViewController(self, didFinishAdding: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

extension AddItemTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        }
        return true
    }
}


