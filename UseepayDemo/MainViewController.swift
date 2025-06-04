//
//  MainViewController.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/4/12.
//

import UIKit
import UseePayCore

class MainViewController: BaseViewController, UseePayDelegate {

    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel1 = UILabel()
    private let pidTitleLabel = UILabel() // 新增 pid 标题
    private let pidTextField = UITextField()
    private let clientSecretTitleLabel = UILabel() // 新增 clientSecret 标题
    private let clientSecretTextField = UITextField()
    private let checkoutButton = UIButton(type: .custom)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Content View
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // pid Title Label
        pidTitleLabel.text = "PID"
        pidTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        pidTitleLabel.textColor = .black
        pidTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pidTitleLabel)
        
        // pid TextField
        pidTextField.placeholder = "PID"
        pidTextField.borderStyle = .none
        pidTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        pidTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pidTextField)
        
        // clientSecret Title Label
        clientSecretTitleLabel.text = "Client Secret"
        clientSecretTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        clientSecretTitleLabel.textColor = .black
        clientSecretTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(clientSecretTitleLabel)
        
        // clientSecret TextField
        clientSecretTextField.placeholder = "Client Secret"
        clientSecretTextField.borderStyle = .none
        clientSecretTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        clientSecretTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(clientSecretTextField)
        
        // Checkout Button
        checkoutButton.setTitle("CHECKOUT", for: .normal)
        checkoutButton.backgroundColor = .systemBlue
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 8
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkoutButton)
        checkoutButton.addTarget(self, action: #selector(clickCheckoutButton), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            // Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View Constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // pid Title Label Constraints
            pidTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            pidTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // pid TextField Constraints
            pidTextField.topAnchor.constraint(equalTo: pidTitleLabel.bottomAnchor, constant: 5),
            pidTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pidTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pidTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // clientSecret Title Label Constraints
            clientSecretTitleLabel.topAnchor.constraint(equalTo: pidTextField.bottomAnchor, constant: 10),
            clientSecretTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // clientSecret TextField Constraints
            clientSecretTextField.topAnchor.constraint(equalTo: clientSecretTitleLabel.bottomAnchor, constant: 5),
            clientSecretTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            clientSecretTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            clientSecretTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Checkout Button Constraints
            checkoutButton.topAnchor.constraint(equalTo: clientSecretTextField.bottomAnchor, constant: 20),
            checkoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            checkoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func clickCheckoutButton() {
        self.view.endEditing(true)
        
        // 使用 @resultBuilder 构造配置
        let configuration = UPPaymentSheetConfiguration.make {
            ThemeModeComponent(mode: .followSystem)
            SheetStyleComponent(inputCornerRadius: 5, payBtnCornerRadius: 8, doneBtnCornerRadius: 8)
            self.payBtnConfig()
            PaymentResultComponent(showPaymentResult: true)
        }
        
        do {
            try UseePay.showPaymentSheet(on: self, withDelegate: self, withConfiguration: configuration, withPid: pidTextField.text ?? "", withClientSecret: clientSecretTextField.text ?? "")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func payBtnConfig() -> PayBtnStyleComponent {
        let lightPayBtnBgColor: UIColor? = UIColor(hex: "#FFFFFF")
        
        let lightPayBtnTextColor: UIColor? = UIColor(hex: "#000000")
        
        let darkPayBtnBgColor: UIColor? = UIColor(hex: "#000000")
        
        let darkPayBtnTextColor: UIColor? = UIColor(hex: "#FFFFFF")
        
        return PayBtnStyleComponent(lightPayBtnBgColor: lightPayBtnBgColor, lightPayBtnTextColor: lightPayBtnTextColor, darkPayBtnBgColor: darkPayBtnBgColor, darkPayBtnTextColor: darkPayBtnTextColor)
    }
    
    // MARK: - UseePayDelegate
    func useePay(didCompletePaymentWithResult result: UseePayCore.UPPaymentResult, message: String?) {
        print("Payment result: \(result.rawValue), message: \(message ?? "None")")
        
        let title = if result == .success {
            "Payment succeded"
        } else {
            "Payment failed"
        }
        
        let delayTime: Double = 0.5 // 秒
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            self.showToast(message: "\(title): \(result.rawValue), message: \(message ?? "None")", duration: 3)
        }
    }
    
    func useePayDidCancel() {
        print("Cancelled")
        let delayTime: Double = 0.5 // 秒

        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            self.showToast(message: "Cancelled", duration: 3)
        }
    }
}

extension UIColor {
    convenience init(hex: String, defaultAlpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // 移除前缀
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        } else if hexString.hasPrefix("0X") {
            hexString = String(hexString.dropFirst(2))
        }
        
        // 检查长度是否合法
        guard [6, 8].contains(hexString.count) else {
            self.init(red: 0, green: 0, blue: 0, alpha: defaultAlpha)
            return
        }
        
        // 解析十六进制值
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        // 根据位数处理
        if hexString.count == 6 {
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: defaultAlpha
            )
        } else {
            self.init(
                red: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(rgbValue & 0x000000FF) / 255.0
            )
        }
    }
}

import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        // 创建 Toast 标签
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0 // 支持多行
        toastLabel.lineBreakMode = .byWordWrapping // 自动换行
        
        // 设置边距
        let padding: CGFloat = 15 // 左右各15px边距
        let maxWidth = min(view.frame.width - 40, 280) // 最大宽度限制
        let textSize = message.boundingRect(
            with: CGSize(width: maxWidth - (2 * padding), height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: toastLabel.font!],
            context: nil
        ).size
        
        let labelWidth = ceil(textSize.width) + (2 * padding)
        let labelHeight = ceil(textSize.height) + 16 // 上下各8px边距
        toastLabel.frame = CGRect(
            x: (view.frame.width - labelWidth) / 2,
            y: view.frame.height - labelHeight - 100,
            width: labelWidth,
            height: labelHeight
        )
        
        // 添加到视图
        view.addSubview(toastLabel)
        
        // 动画显示
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            // 持续显示后淡出
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
}
