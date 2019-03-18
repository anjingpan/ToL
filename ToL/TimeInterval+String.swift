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
        
        if count / 3600 >= 1 {
            result += showTwoDigits(count / 3600)
            result += ":"
            count = count % 60
        }else {
            result += "00:"
        }
        if count / 60 >= 1 {
            result += showTwoDigits(count / 60)
            result += ":"
            count = count % 60
        }else {
            result += "00:"
        }
        
        result += showTwoDigits(count)
        
        return result
    }
    
    //return 格式 00
    static fileprivate func showTwoDigits(_ number: Int) -> String {
        var result = ""
        result += number < 10 ? "0" : ""
        result += "\(number)"
        return result
    }
}
