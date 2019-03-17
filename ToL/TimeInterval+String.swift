//
//  TimeInterval+String.swift
//  ToL
//
//  Created by Jal on 2019/3/17.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

extension TimeInterval {
    static func toCountString(timeInterval: TimeInterval) -> String {
        var result = ""
        
        var count = Int(timeInterval)
        
        if count / 3600 > 1 {
            result += "\(count / 3600):"
            count = count % 60
        }else {
            result += "00:"
        }
        if count / 60 > 1 {
            result += "\(count / 60):"
            count = count % 60
        }else {
            result += "00:"
        }
        
        result += count < 10 ? "0" : ""
        result += "\(count)"
        
        return result
    }
}
