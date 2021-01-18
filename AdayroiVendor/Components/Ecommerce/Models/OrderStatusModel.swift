//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct OrderStatusModel: Codable {
    let _id: String
    let name: String
    let description: String?
    let payment_type: String?
    let note_payment_offline: String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case description = "description"
        case payment_type = "payment_type"
        case note_payment_offline = "note_payment_offline"
    }
}
