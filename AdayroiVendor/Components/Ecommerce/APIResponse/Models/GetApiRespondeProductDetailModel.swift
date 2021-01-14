//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct GetApiRespondeProductDetailModel: Codable {
    let result: String
    let code: Int
    let errorMessage:String
    let product: ProductModel
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage = "errorMessage"
        case product = "data"
    }
}
