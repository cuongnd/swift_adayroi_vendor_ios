//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct GetAffiliateInfoModel: Codable {
    let result: String
    let code: Int=200
    let userAffiliateInfoModel: UserAffiliateInfoModel
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case userAffiliateInfoModel = "data"
    }
}
