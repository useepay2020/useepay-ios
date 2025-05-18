//
//  PayViewController.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/4/12.
//

import UIKit
import UseePayCore

class PayViewController: UIViewController, UseePayDelegate {

    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var currency: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amount.text = "\(PaymentSettings.shared.amount)"
        currency.text = PaymentSettings.shared.currency
        firstName.text = PaymentSettings.shared.firstName
        lastName.text = PaymentSettings.shared.lastName
        email.text = PaymentSettings.shared.email
        
        print("Version: \(UseePay.versionString)")
        
        // 初始化支付sdk
        do {
            try UseePay.setup(env: PaymentSettings.shared.env,
                              merchantNo: PaymentSettings.shared.merchantNo,
                              apiKey: PaymentSettings.shared.apiKey,
                              appId: PaymentSettings.shared.appId)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func clickPayButton(_ sender: Any) {
        self.view.endEditing(true)
        PaymentSettings.shared.amount = if let doubleValue = Double(amount.text ?? "") {
            doubleValue
        } else {
            0.0
        }
        PaymentSettings.shared.currency = currency.text ?? ""
        PaymentSettings.shared.firstName = firstName.text ?? ""
        PaymentSettings.shared.lastName = lastName.text ?? ""
        PaymentSettings.shared.email = email.text ?? ""
        PaymentSettings.shared.save()
        
        createPaymentIntent { [weak self] (response) in
            guard let self = self else { return }
            if (response != nil) {
                DispatchQueue.main.async {
                    
                    // 使用 @resultBuilder 构造配置
                    let configuration = UPPaymentSheetConfiguration.make {
                        ThemeModeComponent(mode: .followSystem)
                        CustomThemeColorComponent(color: .red)
                    }
                    
                    do {
                        try UseePay.showPaymentSheet(on: self, withDelegate: self, withConfiguration: configuration, withPid: response?.id ?? "", withClientSecret: response?.clientSecret ?? "", withAmount: Double(self.amount.text ?? "") ?? 0, withCurrency: self.currency.text ?? "")
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func createPaymentIntent(completion: @escaping (UPPaymentIntentResponse?) -> Void) {
        let customer = UPCustomer(firstName: firstName.text ?? "", lastName: lastName.text ?? "", merchantCustomerId: "\(Int(Date().timeIntervalSince1970))", email: email.text ?? "")
        let intent = UPPaymentIntent(amount: Double(self.amount.text ?? "") ?? 0, currency: self.currency.text ?? "", merchantOrderId: "\(Int(Date().timeIntervalSince1970))", customer: customer)
        
        UPNetworking.shared.createPaymentIntent(intent: intent) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                print("create payment intent error")
                completion(nil)
            }
        }
    }
    
    // MARK: - UseePayDelegate
    func useePay(didCompletePaymentWithResult result: UseePayCore.UPPaymentResult, message: String?) {
        print("Payment result: \(result.rawValue), message: \(message ?? "None")")
    }
    
    func useePayDidCancel() {
        print("Cancelled")
    }
}
