//
//  UPPaymentIntentResponse.swift
//  UseePayKit
//
//  Created by Mingwei Shi on 2025/4/19.
//

import Foundation

struct UPPaymentIntentResponse: Codable {
    let id: String?
    let code: String?
    let source: String?
    let message: String?
    let amount: Int?
    let currency: String?
    let status: String?
    let description: String?
    let order: String?
    let metadata: String?
    let externalRecurringData: String?
    let confirm: Bool?
    let orderType: String?
    let reference: String?
    let sale: Bool?
    let merchantNo: String?
    let appId: String?
    let createAt: String?
    let modifyAt: String?
    let apiVersion: String?
    let merchantOrderId: String?
    let invoiceId: String?
    let capturedAmount: Double?
    let customerId: String?
    let availablePaymentMethodTypes: [String]?
    let paymentMethodOptions: String?
    let cancellationReason: String?
    let cancelledAt: String?
    let nextAction: UPNextAction?
    let returnUrl: String?
    let clientSecret: String?
    let deviceData: String?
    let autoCapture: Bool?
    let mandateId: String?
    let webhookUrl: String?
    let lastPaymentError: String?
    let orderId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case source
        case message
        case amount
        case currency
        case status
        case description
        case order
        case metadata
        case externalRecurringData
        case confirm
        case orderType
        case reference
        case sale
        case merchantNo = "merchant_no"
        case appId = "app_id"
        case createAt = "create_at"
        case modifyAt = "modify_at"
        case apiVersion = "api_version"
        case merchantOrderId = "merchant_order_id"
        case invoiceId = "invoice_id"
        case capturedAmount = "captured_amount"
        case customerId = "customer_id"
        case availablePaymentMethodTypes = "available_payment_method_types"
        case paymentMethodOptions = "payment_method_options"
        case cancellationReason = "cancellation_reason"
        case cancelledAt = "cancelled_at"
        case nextAction = "next_action"
        case returnUrl = "return_url"
        case clientSecret = "client_secret"
        case deviceData = "device_data"
        case autoCapture = "auto_capture"
        case mandateId = "mandate_id"
        case webhookUrl = "webhook_url"
        case lastPaymentError = "last_payment_error"
        case orderId = "order_id"
    }
}

struct UPNextAction: Codable {
    let type: String?
    let data: String?
    let redirect: UPRedirect?
    let alipayRedirect: String?
    let alipayQrcodeDisplay: String?
    let oxxoDisplay: String?
    let boletoDisplay: String?
    let dccData: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
        case redirect
        case alipayRedirect = "alipay_redirect"
        case alipayQrcodeDisplay = "alipay_qrcode_display"
        case oxxoDisplay = "oxxo_display"
        case boletoDisplay = "boleto_display"
        case dccData = "dcc_data"
    }
}

struct UPRedirect: Codable {
    let method: String
    let url: String
    let contentType: String
    
    enum CodingKeys: String, CodingKey {
        case method
        case url
        case contentType = "content_type"
    }
}
