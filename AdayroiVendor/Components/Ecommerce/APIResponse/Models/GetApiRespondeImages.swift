//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct GetApiRespondeImagesByParentModel: Codable {
    let result: String
    let code: Int
    let errorMessage:String
    let list_image: [ImageModel]
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage = "errorMessage"
        case list_image = "data"
    }
}
struct GetApiRespondeImagesColorByProductId: Codable {
    let result: String
    let code: Int
    let errorMessage:String
    let list_image_color: [AttributeColorModel]
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case code = "code"
        case errorMessage = "errorMessage"
        case list_image_color = "data"
    }
}
