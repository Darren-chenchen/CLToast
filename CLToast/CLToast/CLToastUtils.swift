//
//  HDToastUtil.swift
//  Ideal
//
//  Created by darren on 2018/8/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class CLToastUtils: Operation {

    private var _executing = false
    override open var isExecuting: Bool {
        get {
            return self._executing
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            self._executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished = false
    override open var isFinished: Bool {
        get {
            return self._finished
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            self._finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    var textToastView: CLTextToast = CLTextToast()   // 纯文本
    var imageToastView: CLImageToast = CLImageToast()  // 含有图片
    
    var textMessage: String? {
        get { return self.textToastView.text }
        set { self.textToastView.text = newValue }
    }
    
    var imgMessage: String? {
        get { return self.imageToastView.text }
        set { self.imageToastView.text = newValue }
    }
    
    // 动画起始值
    var animationFromValue: CGFloat = 1
    var superComponent: UIView = UIView()
    var showSuccessToast: Bool?  // nil 不展示带图片的toast  true和false都展示imageToastView
    var duration: CGFloat = 2  // 默认展示2秒
    var position = CLToastPosition.middle

    init(msg: String,onView:UIView? = nil,success: Bool? = nil,duration:CGFloat? = nil, position: CLToastPosition? = .middle) {
        
        self.superComponent = onView ?? (UIApplication.shared.keyWindow ?? UIView())
        self.showSuccessToast = success
        self.duration = duration ?? 2
        self.position = position ?? CLToastPosition.middle
        
        super.init()
        
        if self.showSuccessToast == nil {
            self.textMessage = msg
            self.textToastView.position = self.position
        } else {
            self.imgMessage = msg
            self.imageToastView.position = self.position
        }

        // 单利队列中每次都加入一个新建的Operation
        CLToastManager.share.add(self)
    }
    
    open override func cancel() {
        super.cancel()
        self.dismiss()
    }
    override func start() {
        let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
        guard isRunnable else { return }
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }
        main()
    }
    override func main() {
        self.isExecuting = true
        
        DispatchQueue.main.async {
            if self.showSuccessToast == nil {
                self.textToastView.titleLabel.textColor = CLToastManager.share.textColor
                self.textToastView.titleLabel.font = CLToastManager.share.textFont
                self.textToastView.backgroundColor = CLToastManager.share.bgColor
                self.textToastView.layer.cornerRadius = CLToastManager.share.cornerRadius

                self.textToastView.setNeedsLayout()
                self.superComponent.addSubview(self.textToastView)
            } else {
                self.imageToastView.titleLabel.textColor = CLToastManager.share.textColor
                self.imageToastView.titleLabel.font = CLToastManager.share.textFont
                self.imageToastView.backgroundColor = CLToastManager.share.bgColor
                self.imageToastView.layer.cornerRadius = CLToastManager.share.cornerRadius
                
                self.imageToastView.setNeedsLayout()
                self.superComponent.addSubview(self.imageToastView)
                if self.showSuccessToast == true {
                    self.imageToastView.iconView.image = CLToastManager.share.successImage
                }
                if self.showSuccessToast == false {
                    self.imageToastView.iconView.image = CLToastManager.share.failImage
                }
            }
            
            let shakeAnimation = CABasicAnimation.init(keyPath: "transform.scale")
            shakeAnimation.duration = 0.2
            shakeAnimation.fromValue = self.animationFromValue
            shakeAnimation.toValue = 1.1
            shakeAnimation.autoreverses = true
            shakeAnimation.delegate = self
            
            if self.showSuccessToast == nil {
                self.textToastView.layer.add(shakeAnimation, forKey: nil)
            } else {
                self.imageToastView.layer.add(shakeAnimation, forKey: nil)
            }
        }
    }
}

extension CLToastUtils: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            UIView.animate(withDuration: 0.5, delay: TimeInterval(self.duration), options: UIViewAnimationOptions.allowUserInteraction, animations: {
                if self.showSuccessToast == nil {
                    self.textToastView.alpha = 0
                } else {
                    self.imageToastView.alpha = 0
                }
            }) { (finish) in
                self.dismiss()
            }
        }
    }
    
    func dismiss() {
        self.textToastView.removeFromSuperview()
        self.imageToastView.removeFromSuperview()
        self.finish()
    }
    
    func finish() {
        self.isExecuting = false
        self.isFinished = true
        
        if CLToastManager.share.supportQuene == false {
            CLToastManager.share.cancelAll()
        }
    }
}
