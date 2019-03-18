//
//  cacheManage.swift
//  ToL
//
//  Created by yl on 2019/3/18.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

class cacheManage: NSObject {
    // MARK: - Property
    static let sharedInstance = cacheManage()
    
    // MARK: - Life Cycle
    private override init() {
        super.init()
    }
    
    func savaTaskArray(_ array: [taskModel]) {
        let _ = NSKeyedArchiver.archiveRootObject(array, toFile: savaTaskArrayPath())
    }
    
    func getTaskArray() -> [taskModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: savaTaskArrayPath()) as? [taskModel]
    }
}

extension cacheManage {
    fileprivate func savaTaskArrayPath() -> String {
        return "task.arc"
    }
}
