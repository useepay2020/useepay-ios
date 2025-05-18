//
//  UPPaymentIntent.swift
//  UseePayKit
//
//  Created by Mingwei Shi on 2025/4/12.
//

import Foundation

// 支付弹窗配置
class UPPaymentIntent: NSObject, Codable {
    // @required. Payment amount. This is the order amount you would like to charge your customer.
    let amount: Double
    // @required. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    let currency: String
    // @required. The order ID created in merchant's order system that corresponds to this PaymentIntent. Maximum length is 64.
    let merchantOrderId: String
    let customer: UPCustomer
    let deviceData: UPDeviceData
    
    init(amount: Double,
         currency: String,
         merchantOrderId: String,
         customer: UPCustomer) {
        self.amount = amount
        self.currency = currency
        self.merchantOrderId = merchantOrderId
        self.customer = customer
        self.deviceData = UPDeviceData(ipAddress: "2001:0db8:0000:0000:0000:ff00:0042:8329")
        super.init()
    }
    
    // 定义字段映射
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case merchantOrderId = "merchant_order_id"
        case customer
        case deviceData = "device_data"
    }
}

class UPCustomer: NSObject, Codable {
    let firstName: String?
    let lastName: String?
    let merchantCustomerId: String?
    let email: String?
    
    init(firstName: String?, lastName: String?, merchantCustomerId: String?, email: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.merchantCustomerId = merchantCustomerId
        self.email = email
    }
    
    // 定义字段映射
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case merchantCustomerId = "merchant_customer_id"
        case email
    }
}

class UPDeviceData: NSObject, Codable {
    let ipAddress: String
    
    init(ipAddress: String) {
        self.ipAddress = ipAddress
        super.init()
    }
    
    // 定义字段映射
    enum CodingKeys: String, CodingKey {
        case ipAddress = "ip_address"
    }
}
