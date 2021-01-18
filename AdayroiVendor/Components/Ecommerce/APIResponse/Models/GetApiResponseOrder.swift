//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct GetApiResponeUpdateOrderModel: Codable {
    let result: String
    let code: Int
    let errorMessage:String
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage = "errorMessage"
    }
}
struct ApiResponeGetListMyOrders: Codable {
    let result: String
    let code: Int
    let errorMessage:String
    let list_my_orders:[OrderModel]
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage = "errorMessage"
        case list_my_orders = "list_order"
    }
}
