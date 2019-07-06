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
        case high, medium, low, now
    }
    
    private var highPrioriyTodos: [ChecklistItem] = []
    private var mediumPrioriyTodos: [ChecklistItem] = []
    private var lowPrioriyTodos: [ChecklistItem] = []
    private var nowPrioriyTodos: [ChecklistItem] = []
    
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
        addTodo(row2Item, for: .medium)
        addTodo(row3Item, for: .medium)
        addTodo(row4Item, for: .medium)
    }
    
    
    func todoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPrioriyTodos
        case .medium:
            return mediumPrioriyTodos
        case .low:
            return lowPrioriyTodos
        case .now:
            return nowPrioriyTodos
        }
    }
    
    
    func addTodo(_ item: ChecklistItem, for priority: Priority) {
        switch priority {
        case .high:
            return highPrioriyTodos.append(item)
        case .medium:
            return mediumPrioriyTodos.append(item)
        case .low:
            return lowPrioriyTodos.append(item)
        case .now:
            return nowPrioriyTodos.append(item)
        }
    }
    
    func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        mediumPrioriyTodos.append(item)
        return item
    }
    
    func move (item: ChecklistItem, to index: Int) {
//        guard let currentIndex = todos.firstIndex(of: item) else {
//            return
//        }
//        todos.remove(at: currentIndex)
//        todos.insert(item, at: index)
    }
    
    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPrioriyTodos.remove(at: index)
        case .medium:
            mediumPrioriyTodos.remove(at: index)
        case .low:
            lowPrioriyTodos.remove(at: index)
        case .now:
            nowPrioriyTodos.remove(at: index)
            
        }
    }
    

    private func randomTitle() -> String {
        var titles = ["New todo item", "Generic todo", "Fill me out", "Ineed something to do", "Much todo about nothing"]
        let randomNumber = Int.random(in: 0 ..< titles.count)
        return titles[randomNumber]
        
    }
}
