//
//  ViewController.swift
//  ToL
//
//  Created by Jal on 2019/3/17.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

let kTaskTableCellView = "taskTableCellView"

class ViewController: NSViewController {

    // MARK: - Property
    @IBOutlet weak var countDown: countDownView!
    @IBOutlet weak var taskNameTextField: NSTextField!
    @IBOutlet weak var taskTimeTextField: NSTextField!
    @IBOutlet weak var taskLeftTimeLabel: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var giveupButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    fileprivate var startTime: Date?                        //开始计时时间
    fileprivate var endTime: Date?                          //结束计时时间
    fileprivate var currentTaskName: String!                //当前任务名称
    fileprivate var isCounting: Bool = false                //是否正在计时
    
    fileprivate var taskArray: [taskModel]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        taskArray = cacheManage.sharedInstance.getTaskArray()
        
        countDown.delegete = self
        
        addAction()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: - UI
    func addAction() {
        [startButton, giveupButton].forEach { (button) in
            button?.target = self
            button?.action = #selector(buttonClick(_:))
        }
    }

    // MARK: - Action
    @objc func buttonClick(_ sender: NSButton) {
        if sender == startButton {
            //默认：时间为30分钟，任务描述为日常学习
            let taskTimeString = taskTimeTextField.stringValue == "" ? "30" : taskTimeTextField.stringValue
            guard let totalTime = TimeInterval(taskTimeString) else {showWarning("请正确输入时间", .warning); return}
            guard !isCounting else { showWarning("正在进行任务，无法开启新任务", .warning); return }
            currentTaskName = taskNameTextField.stringValue == "" ? "日常学习" : taskNameTextField.stringValue
            countDown.totalTime = totalTime * 60
            countDown.startCount()
        }else if sender == giveupButton {
            guard isCounting else { return }
            let alert = NSAlert()
            alert.messageText = "正在进行任务，是否确认放弃"
            alert.addButton(withTitle: "取消")
            alert.addButton(withTitle: "确认")
            alert.beginSheetModal(for: NSApplication.shared.keyWindow ?? NSWindow()) { (response) in
                //按照添加顺序从1000开始递增
                if response.rawValue == 1001 {
                    //确认
                    self.giveupTask()
                }
            }
            alert.alertStyle = .critical
            
        }
    }
    
    // MARK: - Alert
    func showWarning(_ message: String, _ style: NSAlert.Style) {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "确定")
        alert.alertStyle = style
        alert.runModal()
    }
    
    // MARK: - Function
    func giveupTask() {
        countDown.endCount()
        isCounting = false
        let task = taskModel.init(start: startTime, end: Date(), name: currentTaskName, isCom: false)
        reloadAppendTaskList(task)
    }
    
    func reloadAppendTaskList(_ task: taskModel) {
        if taskArray == nil {
            taskArray = [taskModel]()
        }
        
        taskArray?.append(task)
        cacheManage.sharedInstance.savaTaskArray(taskArray!)
        tableView.reloadData()
    }

}

// MARK: - NSTableView Delegate && Datasource
extension ViewController : NSTableViewDelegate,NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskArray?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: kTaskTableCellView), owner: self) as! taskTableCellView
        cell.taskDetail = taskArray?[row]
        return cell
    }
    
}

// MARK: - CountDownTimer Delegate
extension ViewController : CountDownTimerDelegate {
    func timerDidStart() {
        startTime = Date()
        isCounting = true
    }
    
    func timerUpdateCounting(leftTime: TimeInterval) {
        taskLeftTimeLabel.stringValue = TimeInterval.toCountString(timeInterval: leftTime)
    }
    
    func timerDidFinish() {
        endTime = Date()
        isCounting = false
        showWarning("恭喜你完成任务：" + currentTaskName , .informational)
        let task = taskModel(start: startTime, end: endTime, name: currentTaskName, isCom: true)
        reloadAppendTaskList(task)
    }
}

