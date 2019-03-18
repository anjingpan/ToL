//
//  taskModel.swift
//  ToL
//
//  Created by Jal on 2019/3/18.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

class taskModel: NSObject,NSCoding {
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(startTime, forKey: "startTime")
        aCoder.encode(endTime, forKey: "endTime")
        aCoder.encode(taskName, forKey: "taskName")
        aCoder.encode(isComplete, forKey: "isComplete")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        startTime = aDecoder.decodeObject(forKey: "startTime") as? Date
        endTime = aDecoder.decodeObject(forKey: "endTime") as? Date
        taskName = aDecoder.decodeObject(forKey: "taskName") as? String
        isComplete = aDecoder.decodeObject(forKey: "isComplete") as? Bool
    }
}
