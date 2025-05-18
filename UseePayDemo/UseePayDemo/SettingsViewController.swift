//
//  SettingsViewController.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/5/10.
//

import Foundation
import UIKit
import UseePayCore

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var envSegment: UISegmentedControl!
    
    @IBOutlet weak var merchantNo: UITextField!
    
    @IBOutlet weak var apiKey: UITextView!
    
    @IBOutlet weak var appId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if PaymentSettings.shared.env == .sandbox {
            envSegment.selectedSegmentIndex = 0
        } else {
            envSegment.selectedSegmentIndex = 1
        }
        merchantNo.text = PaymentSettings.shared.merchantNo
        apiKey.text = PaymentSettings.shared.apiKey
        appId.text = PaymentSettings.shared.appId
    }
    
    @IBAction func save(_ sender: Any) {
        if envSegment.selectedSegmentIndex == 0 {
            PaymentSettings.shared.env = .sandbox
        } else {
            PaymentSettings.shared.env = .production
        }
        PaymentSettings.shared.merchantNo = merchantNo.text ?? ""
        PaymentSettings.shared.apiKey = apiKey.text ?? ""
        PaymentSettings.shared.appId = appId.text ?? ""
        PaymentSettings.shared.save()
        
        // 初始化支付sdk
        do {
            try UseePay.setup(env: PaymentSettings.shared.env,
                              merchantNo: PaymentSettings.shared.merchantNo,
                              apiKey: PaymentSettings.shared.apiKey,
                              appId: PaymentSettings.shared.appId)
        } catch let error {
            print(error.localizedDescription)
        }
        
        showToast(message: "保存成功", duration: 2)
    }
    
    func showToast(message: String, duration: TimeInterval) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        // 自动消失
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
