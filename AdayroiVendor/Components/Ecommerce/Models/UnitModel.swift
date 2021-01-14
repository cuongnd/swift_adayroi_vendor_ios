//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct UnitModel: Codable {
    let _id: String
    let name: String
    let user_id: String
    let alias: String
    let description: String
    let published: Int
    let created_date: String
    let modify_date: String
   
    
    enum CodingKeys: String, CodingKey {
       case _id = "_id"
        case name = "name"
        case user_id = "user_id"
        case alias = "alias"
        case description = "description"
        case published = "published"
        case created_date = "created_date"
        case modify_date = "modify_date"
       
    }
    init() {
        _id = ""
        name = ""
        user_id = ""
        alias = ""
        description = ""
        published=1
        created_date=""
        modify_date=""
    }
}
