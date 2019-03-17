//
//  countDownView.swift
//  ToL
//
//  Created by Jal on 2019/3/17.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

@objc protocol CountDownTimerDelegate {
    @objc optional func timerDidStart()
    @objc optional func timerUpdateCounting(leftTime: TimeInterval)
    @objc optional func timerDidFinish()
}

class countDownView: NSView {
    
    // MARK: - Property
    open weak var delegete: CountDownTimerDelegate?
    
    open var countColor: NSColor = NSColor(calibratedRed: 47/255, green: 92/255, blue: 133/255, alpha: 1)            //计时颜色
    open var bgColor: NSColor = NSColor(calibratedRed: 221/255, green: 183/255, blue: 165/255, alpha: 1)               //进度底色
    open var lineWidth: CGFloat = 12
    open var countedTime: TimeInterval = 0                  //当前计数
//    open var totalTime: TimeInterval = 30 * 60              //总时长
    open var totalTime: TimeInterval = 60              //总时长
    open var fireInterval: TimeInterval = 1                 //默认时间间隔
    open var fondSize: CGFloat = 34
    
    fileprivate var timer: Timer?
    fileprivate var leftLabel: NSTextField!

    // MARK: - Life Cycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initView()
    }
    
    required init?(coder decoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: decoder)
        initView()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        leftLabel.frame = CGRect(x: bounds.width * 0.5 - fondSize * 2.5, y: bounds.height * 0.5 - fondSize * 0.5, width: fondSize * 5, height: fondSize)
        
        let radius = dirtyRect.width * 0.5 - lineWidth
        let center = NSPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        
        if countedTime == 0 || countedTime == totalTime {
            let bgPath = NSBezierPath()
            bgPath.lineWidth = lineWidth
            bgPath.appendArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360)
            (countedTime == 0 ? bgColor : countColor).set()
            bgPath.stroke()
        }

        
        let currentAngle = 360 * countedTime / totalTime
        
        let unconverPath = NSBezierPath()
        unconverPath.lineWidth = lineWidth
        unconverPath.appendArc(withCenter: center, radius: radius, startAngle: 360 - CGFloat(currentAngle), endAngle: 0, clockwise: false)
        countColor.set()
        unconverPath.stroke()
        
        let coverPath = NSBezierPath()
        coverPath.lineWidth = lineWidth
        coverPath.appendArc(withCenter: center, radius: radius, startAngle: 360, endAngle: 360 - CGFloat(currentAngle), clockwise: false)
        bgColor.set()
        coverPath.stroke()
        
    }
    
    // MARK: - UI
    func initView() {
        leftLabel = NSTextField()
        leftLabel.font = NSFont.labelFont(ofSize: fondSize)
        leftLabel.isEditable = false
        leftLabel.isBordered = false
        leftLabel.backgroundColor = .clear
        leftLabel.textColor = .white
        leftLabel.stringValue = "00:30:00"
        leftLabel.alignment = NSTextAlignment.center
        addSubview(leftLabel)
    }
    
    //Open Function
    open func startCount() {
        countedTime = 0
        timer?.invalidate()
        
        timer = Timer(timeInterval: fireInterval, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        delegete?.timerDidStart?()
    }
    
    open func endCount() {
        timer?.invalidate()
    }
    
    //Timer
    @objc func timerCountDown() {
        countedTime += fireInterval
        
        if countedTime <= totalTime {
            delegete?.timerUpdateCounting?(leftTime: totalTime - countedTime)
            leftLabel.stringValue = TimeInterval.toCountString(timeInterval: totalTime - countedTime)
            setNeedsDisplay(bounds)
        }else {
            timerEnd()
        }
    }
    
    func timerEnd() {
        timer?.invalidate()
        delegete?.timerDidFinish?()
    }
    
}
