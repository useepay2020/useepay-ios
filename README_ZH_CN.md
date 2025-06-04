# UseePay iOS SDK 集成与使用指南

## 目录
- [前置条件](#前置条件)
- [支持版本](#支持版本)
- [集成方式](#集成方式)
  - [Swift Package Manager (SPM) 集成](#swift-package-manager-spm-集成)
  - [CocoaPods 集成](#cocoapods-集成)
  - [手动集成 Framework](#手动集成-framework)
- [SDK 使用指南](#sdk-使用指南)
  - [初始化配置](#初始化配置)
  - [支付功能实现](#支付功能实现)
  - [支付结果处理](#支付结果处理)

## 前置条件
请确保您已经在UseePay商户后台注册并申请了相关App支付功能，下面是UseePay商户后台地址：
- [沙盒环境](https://mc1.uat.useepay.com/#/login)
- [正式环境](https://mc.useepay.com/#/login)

## 支持版本
- 最低支持 iOS 13.0 及以上版本

## 集成方式

### Swift Package Manager (SPM) 集成

1. **在 Xcode 中添加包依赖**
   - 打开项目，选择 `File` > `Add Packages...`
   - 输入 UseePay 的包仓库 URL: `https://github.com/useepay2020/useepay-ios`
   - 选择版本规则（推荐使用最新稳定版本）
   - 点击 `Add Package`

2. **添加框架到目标**
   - 在添加包后，选择需要集成 UseePay 的目标
   - 确保 `UseePayCore` 被正确链接

3. **配置 Swift 环境**
   - 如果是纯 Objective-C 项目，需要创建一个空的 Swift 文件以启用 Swift 支持
   - Xcode 会提示创建桥接文件，选择创建

### CocoaPods 集成

1. 在 Podfile 中添加：
```ruby
pod 'UseePayCore', '~> 1.0.0'
```
2. 执行安装：
```bash
pod install
```
3. 打开生成的 `.xcworkspace` 文件进行开发

### 手动集成 Framework

1. **下载 Framework**
   - 从 Releases 中下载最新的 `UseePayCore.xcframework`

2. **添加 Framework 到项目**
   - 在项目目录中创建 Frameworks 文件夹
   - 将 `UseePayCore.xcframework` 拷贝到此文件夹
   - 在 Xcode 中，右键项目 > Add Files to "YourProject"...
   - 选择添加 `UseePayCore.xcframework`

3. **设置 Embed & Sign**
   - 在项目设置的 General 标签
   - 找到 Frameworks, Libraries, and Embedded Content
   - 确保 `UseePayCore.xcframework` 设置为 Embed & Sign

## SDK 使用指南

### 初始化配置

建议在 `AppDelegate` 中进行初始化：

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    configureUseePaySDK()
    
    return true
}

private func configureUseePaySDK() {
    // 从安全存储读取配置信息
    let env: Environment = .production  // 或 .sandbox 沙盒环境
    let merchantNo = "您的商户号"
    
    do {
        try UseePay.setup(
            env: env,
            merchantNo: merchantNo
        )
    } catch {
        print("UseePay 初始化失败: \(error.localizedDescription)")
    }
}
```

### 支付功能实现

```swift
func showPaymentSheet() {
    // 创建支付配置
    let configuration = UPPaymentSheetConfiguration.make {
        ThemeModeComponent(mode: .followSystem)  // 主题模式
        SheetStyleComponent(inputCornerRadius: 5, payBtnCornerRadius: 8, doneBtnCornerRadius: 8)
        PayBtnStyleComponent(
            lightPayBtnBgColor: "#FFFFFF",      // 亮色模式按钮背景色
            lightPayBtnTextColor: "#000000",    // 亮色模式按钮文字色
            darkPayBtnBgColor: "#000000",       // 暗色模式按钮背景色
            darkPayBtnTextColor: "#FFFFFF"      // 暗色模式按钮文字色
        )
        PaymentResultComponent(showPaymentResult: true)  // 是否显示支付结果页
    }
    
    // 发起支付
    do {
        try UseePay.showPaymentSheet(
            on: self,                           // 展示的ViewController
            withDelegate: self,                 // 支付结果代理
            withConfiguration: configuration,   // 支付配置
            withPid: "订单ID",                  // 从服务端获取的payment id
            withClientSecret: "客户端密钥"       // 从服务端获取的client secret
        )
    } catch let error as UseePayError {
        handlePaymentError(error)
    } catch {
        print("未知错误: \(error.localizedDescription)")
    }
}
```

### 支付结果处理

```swift
extension YourViewController: UseePayDelegate {
    
    func useePay(didCompletePaymentWithResult result: UPPaymentResult, message: String?) {
        switch result {
        case .succeeded:
            print("支付成功")
            // 注意：此处仅表示客户端支付流程完成，最终结果应以服务端查询为准
            // 建议在此处向您的服务端查询订单最终状态
            
        case .failed:
            if let msg = message {
                print("支付失败: \(msg)")
            }
            // 处理支付失败逻辑
            
        @unknown default:
            break
        }
    }
    
    func useePayDidCancel() {
        print("用户取消支付")
        // 处理用户取消支付逻辑
    }
}
```

## 注意事项
1. `PaymentResult succeeded` 状态不表示支付一定成功，可能是成功或待银行确认状态
2. 支付流程结束后，必须向您的服务端查询订单最终状态
3. 生产环境请确保使用 `Environment.production`
4. 支付配置中的颜色值请使用16进制格式字符串