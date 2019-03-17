//
//  taskTableCellView.swift
//  ToL
//
//  Created by Jal on 2019/3/18.
//  Copyright © 2019 anjing. All rights reserved.
//

import Cocoa

class taskTableCellView: NSTableCellView {
    
    // MARK: - Property
    open var taskDetail: taskModel? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd  HH:mm:ss"
            startTimeLabel.stringValue = "开始："
            if let start = taskDetail?.startTime {
                startTimeLabel.stringValue += formatter.string(from: start)
            }
            endTimeLabel.stringValue = "结束："
            if let end = taskDetail?.endTime {
                endTimeLabel.stringValue += formatter.string(from: end)
            }
            taskDesprition.stringValue = "你" + (taskDetail?.isComplete == true ? "完成" : "放弃") + "了番茄任务："
            taskDesprition.stringValue += taskDetail?.taskName ?? ""
        }
    }
    
    @IBOutlet weak var startTimeLabel: NSTextField!
    @IBOutlet weak var endTimeLabel: NSTextField!
    @IBOutlet weak var taskDesprition: NSTextField!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
