//
//  taskModel.swift
//  ToL
//
//  Created by Jal on 2019/3/18.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

class taskModel: NSObject {
    var startTime: Date?
    var endTime: Date?
    var taskName: String?
    var isComplete: Bool?
    
    override init() {
        super.init()
    }
    
    convenience init(start: Date?, end: Date?, name: String?, isCom: Bool?) {
        self.init()
        
        startTime = start
        endTime = end
        taskName = name
        isComplete = isCom
    }
}
