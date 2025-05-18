# UseePay SDK 集成与使用指南

## 目录
- [支持版本](#支持版本)
- [集成方式](#集成方式)
  - [Swift Package Manager (SPM) 集成](#swift-package-manager-spm-集成)
  - [CocoaPods 集成](#cocoapods-集成方式)
  - [手动集成 Framework](#手动集成-framework)
- [SDK 使用指南](#sdk-使用指南)
  - [初始化配置](#初始化配置)
  - [支付功能实现](#支付功能实现)
  - [支付结果处理](#支付结果处理)

## 支持版本
- 最低支持 iOS 13.0 及以上版本

## 集成方式

### Swift Package Manager (SPM) 集成

1. **在 Xcode 中添加包依赖**
   - 打开项目，选择 `File` > `Add Packages...`
   - 输入 UseePay 的包仓库 URL(https://github.com/useepay2020/useepay-ios)
   - 选择版本规则（推荐使用最新稳定版本）
   - 点击 `Add Package`

2. **添加框架到目标**
   - 在添加包后，选择需要集成 UseePay 的目标
   - 确保 `UseePayCore` 被正确链接

3. **配置 Swift 环境**
   - 如果是纯 Objective-C 项目，需要创建一个空的 Swift 文件以启用 Swift 支持
   - Xcode 会提示创建桥接文件，选择创建

### CocoaPods 集成方式

1. 在 Podfile 中添加：
```ruby
pod 'UseePay', '~> 1.0.0'
```
2.执行安装：
```ruby
pod install
```
3.打开 .xcworkspace 文件进行开发

### 手动集成 Framework
1. **下载 Framework**
    - 从 Releases 中下载最新的 UseePayCore.xcframework
2. **添加 Framework 到项目**
    - 在项目目录中创建 Frameworks 文件夹
    - 将 UseePayCore.xcframework 拷贝到此文件夹
    - 在 Xcode 中，右键项目 > Add Files to "YourProject"...
    - 选择添加 UseePayCore.xcframework
3. **设置 Embed & Sign**
    - 在项目设置的 General 标签
    - 找到 Frameworks, Libraries, and Embedded Content
    - 确保 UseePayCore.xcframework 设置为 Embed & Sign

### SDK 使用指南
**初始化配置**
```swift
// 建议在 AppDelegate 中初始化
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    configureUseePaySDK()
    
    return true
}

private func configureUseePaySDK() {
    // 从安全存储读取配置信息
    let env: Environment = .production
    let merchantNo = ""
    let apiKey = ""
    let appId = ""
    
    do {
        try UseePay.setup(
            env: env,
            merchantNo: merchantNo,
            apiKey: apiKey,
            appId: appId
        )
    } catch {
        print("初始化失败: \(error.localizedDescription)")
    }
}
```
**支付功能实现**
```swift
func showPaymentSheet() {
    // 创建高级配置
    let configuration = UPPaymentSheetConfiguration.make {
        // 主题模式
        ThemeModeComponent(mode: .dark)  // .light, .dark, .followSystem
        
        // 自定义主题色
        CustomThemeColorComponent(color: UIColor.systemBlue)
    }
    
    // 发起支付
    do {
        try UseePay.showPaymentSheet(
            on: self,
            withDelegate: self,
            withConfiguration: configuration,
            withPid: "ORDER_ID",
            withClientSecret: "SECRET",
            withAmount: 99.99,
            withCurrency: "USD"
        )
    } catch let error as UseePayError {
        handlePaymentError(error)
    } catch {
        print("未知错误: \(error.localizedDescription)")
    }
}
```
**支付结果处理**
```swift
extension PaymentViewController: UseePayDelegate {
    
    func useePay(didCompletePaymentWithResult result: UPPaymentResult, message: String?) {
        switch result {
        case .succeeded:
            print("支付成功")
            // 更新订单状态等操作
            
        case .failed:
            if let msg = message {
                print("支付失败: \(msg)")
            }
            
        @unknown default:
            break
        }
    }
    
    func useePayDidCancel() {
        print("用户取消支付")
    }
}
```
