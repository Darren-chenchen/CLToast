//
//  ViewController.swift
//  CLToast
//
//  Created by darren on 2018/8/24.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var textF: UITextField = {
        let text = UITextField.init(frame: CGRect.zero)
        return text
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:40,width:KScreenWidth,height:KScreenHeight-40-100), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return tableView
    }()
    lazy var bottomView: UIView = {
        let bottom  = UIView.init(frame: CGRect.init(x: 50, y: KScreenHeight-80, width: KScreenWidth-100, height: 80))
        bottom.backgroundColor = UIColor.red
        return bottom
    }()
    
    var titleArr = ["展示纯文本，在window上默认2s",
                    "展示纯文本，在指定view上。指定3s",
                    "展示有图片的成功消息，默认在window上，默认2s",
                    "展示有图片的失败消息，在指定view上，指定3s",
                    "测试纯文本文字较多的情况",
                    "测试含有图片的文本文字较多的情况",
                    "测试顶部出现",
                    "测试底部出现",
                    "测试底部出现，文字较多",
                    "测试底部出现，键盘弹出，文字自动上移",
                    "测试展示在指定的view上",
                    "测试更换成功图片",
                    "修改toast的属性",
                    "重置toast的属性",
                    "测试禁止多任务顺序执行，连续点击，只toast一次"
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.textF)
        self.view.addSubview(tableView)
        self.view.addSubview(self.bottomView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "ID"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: ID)
        }
        cell?.textLabel?.text = titleArr[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            CLToast.cl_show(msg: "展示纯文本，在window上默认2s")
        } else if indexPath.row == 1 {
            CLToast.cl_show(msg: "展示纯文本，在指定view上。指定3s", onView: self.view, duration: 3)
        }else if indexPath.row == 2 {
            CLToast.cl_show(msg: "展示有图片的成功消息，默认在window上，默认2s", success: true)
        }
        else if indexPath.row == 3 {
            CLToast.cl_show(msg: "展示有图片的失败消息，在指定view上，指定3s",onView: self.view, success: false,duration: 3)
        }
        else if indexPath.row == 4 {
            CLToast.cl_show(msg: "测试纯文本文字较多的情况, 展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s展示纯文本，在window上默认2s")
        }
        else if indexPath.row == 5 {
            CLToast.cl_show(msg: "测试含有图片的文本文字较多的情况, 测试含有图片的文本文字较多的情况, 测试含有图片的文本文字较多的情况, 测试含有图片的文本文字较多的情况", success: true)
        }
        else if indexPath.row == 6 {
            CLToast.cl_show(msg: "测试顶部出现", position: CLToastPosition.top)
        }
        else if indexPath.row == 7 {
            CLToast.cl_show(msg: "测试底部出现", position: CLToastPosition.bottom)
        }
        else if indexPath.row == 8 {
            CLToast.cl_show(msg: "测试底部出现，文字较多，文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多文字较多", position: CLToastPosition.bottom)
        }
        else if indexPath.row == 9 {
            CLToast.cl_show(msg: "测试底部出现", duration: 8, position: CLToastPosition.bottom)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.textF.becomeFirstResponder()
            }
        }
        else if indexPath.row == 10 {
            CLToast.cl_show(msg: "测试展示在指定的view上， 测试展示在指定的view上测试展示在指定的view上，测试展示在指定的view上", onView: self.bottomView)
        }
        else if indexPath.row == 11 {
            CLToastManager.share.successImage = UIImage(named: "message_success")
            CLToast.cl_show(msg: "测试更换成功图片", success: true)
        }
        else if indexPath.row == 12 {
            CLToastManager.share.successImage = UIImage(named: "message_success")
            CLToastManager.share.textFont = UIFont.boldSystemFont(ofSize: 20)
            CLToastManager.share.textColor = UIColor.red
            CLToastManager.share.bgColor = UIColor(white: 0, alpha: 0.5)
            CLToastManager.share.cornerRadius = 8
            CLToast.cl_show(msg: "修改toast的属性,修改toast的属性", success: true)
        }
        else if indexPath.row == 13 {
            CLToastManager.share.cl_resetDefaultProps()
            CLToast.cl_show(msg: "重置toast的属性", success: true)
        }
        else if indexPath.row == 14 {
            CLToastManager.share.supportQuene = false
            CLToast.cl_show(msg: "测试禁止多任务顺序执行", success: true)
        }
    }

}

