//
//  TodoList.swift
//  Checklist
//
//  Created by jelly on 03/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import Foundation


class TodoList {
    enum Priority: Int, CaseIterable {
        case high, medium, low, no
    }
    
    private var highPrioriyTodos: [ChecklistItem] = []
    private var mediumPrioriyTodos: [ChecklistItem] = []
    private var lowPrioriyTodos: [ChecklistItem] = []
    private var noPrioriyTodos: [ChecklistItem] = []
    
    init() {
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        
        row0Item.text = "take a jog"
        row1Item.text = "watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design patterns"
        
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .medium)
        addTodo(row2Item, for: .high)
        addTodo(row3Item, for: .low)
        addTodo(row4Item, for: .no)
    }
    
    
    func todoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPrioriyTodos
        case .medium:
            return mediumPrioriyTodos
        case .low:
            return lowPrioriyTodos
        case .no:
            return noPrioriyTodos
        }
    }
    
    
    func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
        switch priority {
        case .high:
            if index < 0 {
                return highPrioriyTodos.append(item)
            } else {
                highPrioriyTodos.insert(item, at: index)
            }
        case .medium:
            if index < 0 {
                mediumPrioriyTodos.append(item)
            } else {
                mediumPrioriyTodos.insert(item, at: index)
            }

        case .low:
            if index < 0 {
                lowPrioriyTodos.append(item)
            } else {
                lowPrioriyTodos.insert(item, at: index)
            }

        case .no:
            if index < 0 {
                noPrioriyTodos.append(item)
            } else {
                noPrioriyTodos.insert(item, at: index)
            }
        }
    }
    
    func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        mediumPrioriyTodos.append(item)
        return item
    }
    
    func move (item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int) {
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
        
    }
    
    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPrioriyTodos.remove(at: index)
        case .medium:
            mediumPrioriyTodos.remove(at: index)
        case .low:
            lowPrioriyTodos.remove(at: index)
        case .no:
            noPrioriyTodos.remove(at: index)
            
        }
    }
    

    private func randomTitle() -> String {
        var titles = ["New todo item", "Generic todo", "Fill me out", "Ineed something to do", "Much todo about nothing"]
        let randomNumber = Int.random(in: 0 ..< titles.count)
        return titles[randomNumber]
        
    }
}
