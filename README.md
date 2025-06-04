# UseePay Payment SDK Integration and Usage Guide
## English | [中文](README_ZH_CN.md)
## Table of Contents
- [Prerequisites](#prerequisites)
- [Supported Versions](#supported-versions)
- [Integration Methods](#integration-methods)
  - [Swift Package Manager (SPM) Integration](#swift-package-manager-spm-integration)
  - [CocoaPods Integration](#cocoapods-integration)
  - [Manual Framework Integration](#manual-framework-integration)
- [SDK Usage Guide](#sdk-usage-guide)
  - [Initialization Configuration](#initialization-configuration)
  - [Payment Function Implementation](#payment-function-implementation)
  - [Payment Result Handling](#payment-result-handling)

## Prerequisites
Ensure you have registered and applied for the relevant App payment features in the UseePay merchant backend. Below are the UseePay merchant backend addresses:
- [Sandbox](https://mc1.uat.useepay.com/#/login)
- [Production](https://mc.useepay.com/#/login)

## Supported Versions
- Minimum support for iOS 13.0 and above

## Integration Methods

### Swift Package Manager (SPM) Integration

1. **Add Package Dependency in Xcode**
   - Open your project, select `File` > `Add Packages...`
   - Enter the UseePay package repository URL: `https://github.com/useepay2020/useepay-ios`
   - Select the version rule (recommended to use the latest stable version)
   - Click `Add Package`

2. **Add Framework to Target**
   - After adding the package, select the target that needs to integrate UseePay
   - Ensure `UseePayCore` is correctly linked

3. **Configure Swift Environment**
   - For pure Objective-C projects, create an empty Swift file to enable Swift support
   - Xcode will prompt to create a bridging header; select "Create"

### CocoaPods Integration

1. Add to Podfile:
```ruby
pod 'UseePayCore', '~> 1.0.0'
```
2. Execute installation:
```bash
pod install
```
3. Open the generated `.xcworkspace` file for development

### Manual Framework Integration

1. **Download Framework**
   - Download the latest `UseePayCore.xcframework` from Releases

2. **Add Framework to Project**
   - Create a Frameworks folder in the project directory
   - Copy `UseePayCore.xcframework` to this folder
   - In Xcode, right-click the project > Add Files to "YourProject"...
   - Select and add `UseePayCore.xcframework`

3. **Set Embed & Sign**
   - In the project settings under the General tab
   - Find Frameworks, Libraries, and Embedded Content
   - Ensure `UseePayCore.xcframework` is set to Embed & Sign

## SDK Usage Guide

### Initialization Configuration

It is recommended to initialize in `AppDelegate`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    configureUseePaySDK()
    
    return true
}

private func configureUseePaySDK() {
    // Read configuration from secure storage
    let env: Environment = .production  // or .sandbox for sandbox environment
    let merchantNo = "Your merchant number"
    
    do {
        try UseePay.setup(
            env: env,
            merchantNo: merchantNo
        )
    } catch {
        print("UseePay initialization failed: \(error.localizedDescription)")
    }
}
```

### Payment Function Implementation

```swift
func showPaymentSheet() {
    // Create payment configuration
    let configuration = UPPaymentSheetConfiguration.make {
        ThemeModeComponent(mode: .followSystem)  // Theme mode
        SheetStyleComponent(inputCornerRadius: 5, payBtnCornerRadius: 8, doneBtnCornerRadius: 8)
        PayBtnStyleComponent(
            lightPayBtnBgColor: "#FFFFFF",      // Light mode button background color
            lightPayBtnTextColor: "#000000",    // Light mode button text color
            darkPayBtnBgColor: "#000000",       // Dark mode button background color
            darkPayBtnTextColor: "#FFFFFF"      // Dark mode button text color
        )
        PaymentResultComponent(showPaymentResult: true)  // Whether to show payment result page
    }
    
    // Initiate payment
    do {
        try UseePay.showPaymentSheet(
            on: self,                           // ViewController to display
            withDelegate: self,                 // Payment result delegate
            withConfiguration: configuration,   // Payment configuration
            withPid: "Order ID",               // Payment ID obtained from the server
            withClientSecret: "Client secret"   // Client secret obtained from the server
        )
    } catch let error as UseePayError {
        handlePaymentError(error)
    } catch {
        print("Unknown error: \(error.localizedDescription)")
    }
}
```

### Payment Result Handling

```swift
extension YourViewController: UseePayDelegate {
    
    func useePay(didCompletePaymentWithResult result: UPPaymentResult, message: String?) {
        switch result {
        case .succeeded:
            print("Payment successful")
            // Note: This only indicates the client-side payment process is complete; the final result should be confirmed by querying the server
            // It is recommended to query the final order status from your server here
            
        case .failed:
            if let msg = message {
                print("Payment failed: \(msg)")
            }
            // Handle payment failure logic
            
        @unknown default:
            break
        }
    }
    
    func useePayDidCancel() {
        print("User canceled payment")
        // Handle user cancellation logic
    }
}
```

## Notes
1. The `PaymentResult succeeded` status does not guarantee payment success; it may indicate success or pending bank confirmation.
2. After the payment process completes, you must query the final order status from your server.
3. For the production environment, ensure you use `Environment.production`.
4. For color values in the payment configuration, use hexadecimal format strings.