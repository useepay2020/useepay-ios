//
//  PaymentSettings.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/5/10.
//

import Foundation
import UseePayCore

class PaymentSettings {
    var env: UPNetworkingEnv
    var merchantNo: String
    var apiKey: String
    var appId: String
    
    var amount: Double
    var currency: String
    var firstName: String
    var lastName: String
    var email: String
    
    static let shared: PaymentSettings = {
        let instance = PaymentSettings()
        return instance
    }()
    
    private init() {
        env = UPNetworkingEnv(rawValue: (UserDefaults.standard.integer(forKey: "UseePayEnv") )) ?? UPNetworkingEnv.sandbox
        merchantNo = UserDefaults.standard.string(forKey: "UseePayMerchantNo") ?? ""
        apiKey = UserDefaults.standard.string(forKey: "UseePayAPIKey") ?? ""
        appId = UserDefaults.standard.string(forKey: "UseePayAPPID") ?? ""
        amount = UserDefaults.standard.double(forKey: "UseePayAmount") 
        currency = UserDefaults.standard.string(forKey: "UseePayCurrency") ?? ""
        firstName = UserDefaults.standard.string(forKey: "UseePayFirstName") ?? ""
        lastName = UserDefaults.standard.string(forKey: "UseePayLastName") ?? ""
        email = UserDefaults.standard.string(forKey: "UseePayEmail") ?? ""
    }
    
    func save() {
        UserDefaults.standard.setValue(env.rawValue, forKey: "UseePayEnv")
        UserDefaults.standard.setValue(merchantNo, forKey: "UseePayMerchantNo")
        UserDefaults.standard.setValue(apiKey, forKey: "UseePayAPIKey")
        UserDefaults.standard.setValue(appId, forKey: "UseePayAPPID")
        UserDefaults.standard.setValue(amount, forKey: "UseePayAmount")
        UserDefaults.standard.setValue(currency, forKey: "UseePayCurrency")
        UserDefaults.standard.setValue(firstName, forKey: "UseePayFirstName")
        UserDefaults.standard.setValue(lastName, forKey: "UseePayLastName")
        UserDefaults.standard.setValue(email, forKey: "UseePayEmail")
        UserDefaults.standard.synchronize()
    }
}
