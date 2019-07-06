//
//  CheckListItem.swift
//  Checklist
//
//  Created by jelly on 03/07/2019.
//  Copyright © 2019 jellyms. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    @objc var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}
