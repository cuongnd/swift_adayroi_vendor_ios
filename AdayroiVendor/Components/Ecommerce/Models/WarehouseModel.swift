//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct WarehouseModel: Codable {
    let _id: String
    let user_id: String
    let warehouse_name: String
    let warehouse_address: String
    let warehouse_phonenumber: String
    let create_date: String
    let modify_date: String
   
    
    enum CodingKeys: String, CodingKey {
       case _id = "_id"
        case user_id = "user_id"
        case warehouse_name = "warehouse_name"
        case warehouse_address = "warehouse_address"
        case warehouse_phonenumber = "warehouse_phonenumber"
        case create_date = "create_date"
        case modify_date = "modify_date"
    }
}
