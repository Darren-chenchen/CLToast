# 该库不再维护，请参考更加完善的组件库

# [IDealist](https://github.com/Darren-chenchen/IDealist)
# CLToast IOS Toast弹框提示组件

![Pod Version](https://img.shields.io/cocoapods/v/CLToast.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/CLToast.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/CLToast.svg?style=flat)

# 要求

- iOS 8.0+
- swift 3.0+

# 主要功能：

- 支持多个Toast任务依次执行
- 支持设置toast的位置
- 键盘弹出不会遮盖toast
- 支持修改Toast的背景色、字体大小、圆角角度
- 支持更换toast的图片资源
- 支持横竖屏切换

# 更新日志

-版本号 1.0.0：项目初始化

# 使用方式

pod 'CLToast'

# Toast的使用
```
public enum CLToastPosition {
    case top
    case middle
    case bottom
}

public class CLToast: NSObject {
    // 默认纯文本、展示在window上、2秒消失、中间位置
    // onView: 可以指定显示在指定的view上
    // success=nil,展示纯文本，success=false展示错误的图片，	success=true展示成功的图片
    // position: 展示的位置
    public static func cl_show(msg: String, onView:UIView? = nil,success: Bool? = nil,duration:CGFloat? = nil, position: CLToastPosition? = .middle) {
        _ = CLToastUtil.init(msg: msg, onView: onView, success: success, duration: duration, position: position)
    } 
}
```


#### 1.展示纯文本提示框(HDToast)
![logo](http://images2015.cnblogs.com/blog/818253/201707/818253-20170705151844784-1921693442.png)

	// 默认展示在window上，默认2秒消失
	CLToast.cl_show(msg: "展示纯文本，在window上默认2s")
	
	// 展示在指定view上默认2秒，可指定时间
	CLToast.cl_show(msg: "展示纯文本，在指定view上。指定3s", onView: self.view, duration: 3)

#### 2.成功的提示框
![logo](http://images2015.cnblogs.com/blog/818253/201707/818253-20170705151857300-1222661027.png)

    CLToast.cl_show(msg: "展示有图片的成功消息，默认在window上，默认2s", success: true)

    CLToast.cl_show(msg: "展示有图片的失败消息，在指定view上，指定3s",onView: self.view, success: false,duration: 3)
    

#### 3.更换图片

```
CLToastManager.share.successImage = UIImage(named: "message_success")
CLToast.cl_show(msg: "测试更换成功图片", success: true)
```

#### 4.修改toast属性

```
CLToastManager.share.successImage = UIImage(named: "message_success")
CLToastManager.share.textFont = UIFont.boldSystemFont(ofSize: 20)
CLToastManager.share.textColor = UIColor.red
CLToastManager.share.bgColor = UIColor(white: 0, alpha: 0.5)
CLToastManager.share.cornerRadius = 8
CLToast.cl_show(msg: "修改toast的属性,修改toast的属性", success: true)
```

#### 5.取消队列任务

	CLToastManager.share.supportQuene = false

# 使用注意

1.由于CLToastManager 是一个单例对象，当设置响应的属性后，那整个项目的toast就会保持整个属性值。如果项目toast较为统一，那么只要在appdelegate中设置一次即可，如果只是想偶尔改变一次toast的属性值，那么再改变之后，记得重新设置。

