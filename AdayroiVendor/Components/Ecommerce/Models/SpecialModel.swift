//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct SpecialsModel: Codable {
    let _id: String
    let title: String
    let value: String
    let product_id:String
    
    
    enum CodingKeys: String, CodingKey {
       case _id = "_id"
        case title = "title"
        case value = "value"
        case product_id = "product_id"
       
    }
    init() {
        _id = ""
        title = ""
        value = ""
        product_id=""
    }
}
