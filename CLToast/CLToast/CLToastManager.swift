//
//  HDToastQueue.swift
//  Ideal
//
//  Created by darren on 2018/8/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public class CLToastManager: NSObject {
    public static let share = CLToastManager()
    
    public var successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var failImage = UIImage(named: "icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var bgColor = UIColor.black
    public var textColor = UIColor.white
    public var textFont = UIFont.systemFont(ofSize: 16)
    public var cornerRadius: CGFloat = 5

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public func reset() {
        self.bgColor = UIColor.black
        self.textColor = UIColor.white
        self.textFont = UIFont.systemFont(ofSize: 16)
        self.cornerRadius = 5
    }
    
    func add(_ toast: CLToastUtils) {
        self.queue.addOperation(toast)
    }
    open func cancelAll() {
        queue.cancelAllOperations()
    }
}
