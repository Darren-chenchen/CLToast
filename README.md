# Ideal IOS 组件库

![Pod Version](https://img.shields.io/cocoapods/v/HDIdeal.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/HDIdeal.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/HDIdeal.svg?style=flat)

# 要求

- iOS 8.0+
- swift 3.0+
- 为了区别Ideal组件库内的方法和类名，Ideal组件库的类名统一全部以“HD”开头，声明为pulic或open的方法名均以 “hd_” 开头

# 主要功能：

- 网络库的封装
- Dialog对话框
- Toast提示框
- 加载框组件
- 更新组件
- UI组件

# 更新日志

-版本号 0.0.0：项目初始化

-版本号 0.0.3：HDToast组件修改

# 使用方式

pod 'Ideal'

Ideal组件库依赖一些基本的第三方框架，详细情况参考.podspec文件

# Toast的使用

- 支持多个Toast任务依次执行
- 支持设置toast的位置
- 键盘弹出不会遮盖toast

```
public enum HDToastPosition {
    case top
    case middle
    case bottom
}

public class HDToast: NSObject {
    // 默认纯文本、展示在window上、2秒消失、中间位置
    // onView: 可以指定显示在指定的view上
    // success=nil,展示纯文本，success=false展示错误的图片，	success=true展示成功的图片
    // position: 展示的位置
    public static func hd_show(msg: String, onView:UIView? = nil,success: Bool? = nil,duration:CGFloat? = nil, position: HDToastPosition? = .middle) {
        _ = HDToastUtil.init(msg: msg, onView: onView, success: success, duration: duration, position: position)
    } 
}
```


#### 1.展示纯文本提示框(HDToast)
![logo](http://images2015.cnblogs.com/blog/818253/201707/818253-20170705151844784-1921693442.png)

	// 默认展示在window上，默认2秒消失
	HDToast.hd_show(msg: "展示纯文本，在window上默认2s")
	
	// 展示在指定view上默认2秒，可指定时间
	HDToast.hd_show(msg: "展示纯文本，在指定view上。指定3s", onView: self.view, duration: 3)

#### 2.成功的提示框
![logo](http://images2015.cnblogs.com/blog/818253/201707/818253-20170705151857300-1222661027.png)

    HDToast.hd_show(msg: "展示有图片的成功消息，默认在window上，默认2s", success: true)

    HDToast.hd_show(msg: "展示有图片的失败消息，在指定view上，指定3s",onView: self.view, success: false,duration: 3)


