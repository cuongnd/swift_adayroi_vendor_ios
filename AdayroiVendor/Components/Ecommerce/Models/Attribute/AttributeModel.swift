//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct AttributeColorModel: Codable {
    let _id: String
    let attribute_header_id: String
    let name: String
    let price:Double
    let value: String
    let product_id: String
    let img_path: String
    
    enum CodingKeys: String, CodingKey {
       case _id = "_id"
        case attribute_header_id = "attribute_header_id"
        case name = "name"
        case price = "price"
        case value = "value"
        case product_id = "product_id"
        case img_path = "img_path"
       
    }
    init() {
        _id = ""
        attribute_header_id = ""
        name = ""
        price = 0.0
        value = ""
        product_id=""
        img_path=""
    }
}
struct HeadAttributeModel: Codable {
    let _id: String
    let attribute_header_id: String
    let name: String
    let price:Double
    let value: String
    let product_id: String
    let img_path: String
    
    enum CodingKeys: String, CodingKey {
       case _id = "_id"
        case attribute_header_id = "attribute_header_id"
        case name = "name"
        case price = "price"
        case value = "value"
        case product_id = "product_id"
        case img_path = "img_path"
       
    }
    init() {
        _id = ""
        attribute_header_id = ""
        name = ""
        price = 0.0
        value = ""
        product_id=""
        img_path=""
    }
}

