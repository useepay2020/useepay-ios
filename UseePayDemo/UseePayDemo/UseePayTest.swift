//
//  UseePayTest.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/5/3.
//

import Foundation
import UseePayCore

extension UPNetworking {
    /// 创建payment intent
    func createPaymentIntent(intent: UPPaymentIntent, completion: @escaping (Result<UPPaymentIntentResponse, Error>) -> Void) {
        guard let dict = classToDictionary(intent) else {
            completion(.failure(NSError(domain: "参数转换失败", code: -1)))
            return
        }
        
        request("api/v1/payment_intents/create", method: .post, parameters: dict) { result in
            switch result {
            case .success(let data):
                // 首先确保data是Dictionary类型
                guard let responseDict = data as? [String: Any] else {
                    completion(.failure(NSError(domain: "返回数据类型错误，预期是Dictionary", code: -2)))
                    return
                }
                
                do {
                    // 将Dictionary转换为Data再解码
                    let jsonData = try JSONSerialization.data(withJSONObject: responseDict)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(UPPaymentIntentResponse.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
