//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct GetApiResponseSubCategoryModel: Codable {
    let result: String
    let errorMessage: String
    let code: Int=200
    let list_sub_category: [SubCategoryModel]
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage="errorMessage"
        case list_sub_category = "data"
    }
}
