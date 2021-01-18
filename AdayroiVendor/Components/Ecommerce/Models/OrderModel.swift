//
//  ObjectMapperFrontendCart.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct OrderModel: Codable {
    let order_id: String
    let trans_status_title: String
    let payment_method_name: String
    let created_date: String
    let modify_date: String
    let customer_id: String
    let user_affiliate_id: String
    let utm_source: String
    let user_id: String
    let payment_method_id: String
    let order_status_id: String
    let order_number: String
    let payment_type: String
    let billing_address_1: String
    let billing_address_2: String
    let billing_city: String
    let billing_company: String
    let billing_email: String
    let billing_full_name: String
    let billing_phone: String
    let billing_postal_code: String
    let contact_name: String
    let coupon_discount_amount: Double
    let currency_short_form: String
    let currency_symbol: String
    let is_bank: Int
    let memo: String
    let payment_method_amount: Int
    let payment_discount_percent: Int
    let shipping_full_name: String
    let shipping_address_1: String
    let shipping_address_2: String
    let shipping_city: String
    let shipping_company: String
    let shipping_email: String
    let shipping_method_amount: String
    let shipping_method_name: String
    let shipping_phone: String
    let shipping_postal_code: String
    var total_amount_product:Int
    var total_cost_befor_tax:Double
    var discount_amount:Double
    var toal_cost_after_discount_and_befor_tax:Double
    var tax_percent:Int
    var tax_amount:Double
    var shipping_amount:Double
    var shiping_tax_percent:Int
    var shiping_tax_amount:Double
    var total_cost_final: Double
    let shipping_tax_percent: Int
    let trans_status_id: String
    let user: OrderUserModel?
    let orderStatus: OrderStatusModel?
    let list_product: [OrderProductModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case order_id = "_id"
        case trans_status_title = "trans_status_title"
        case payment_method_name = "payment_method_name"
        case created_date = "created_date"
        case modify_date = "modify_date"
        case customer_id = "customer_id"
        case user_affiliate_id = "user_affiliate_id"
        case utm_source = "utm_source"
        case user_id = "user_id"
        case payment_method_id = "payment_method_id"
        case order_status_id = "order_status_id"
        case order_number = "order_number"
        case payment_type = "payment_type"
        case billing_address_1 = "billing_address_1"
        case billing_address_2 = "billing_address_2"
        case billing_city = "billing_city"
        case billing_company = "billing_company"
        case billing_email = "billing_email"
        case billing_full_name = "billing_full_name"
        case billing_phone = "billing_phone"
        case billing_postal_code = "billing_postal_code"
        case contact_name = "contact_name"
        case coupon_discount_amount = "coupon_discount_amount"
        case currency_short_form = "currency_short_form"
        case currency_symbol = "currency_symbol"
        case is_bank = "is_bank"
        case memo = "memo"
        case payment_method_amount = "payment_method_amount"
        case payment_discount_percent = "payment_discount_percent"
        case shipping_full_name = "shipping_full_name"
        case shipping_address_1 = "shipping_address_1"
        case shipping_address_2 = "shipping_address_2"
        case shipping_city = "shipping_city"
        case shipping_company = "shipping_company"
        case shipping_email = "shipping_email"
        case shipping_method_amount = "shipping_method_amount"
        case shipping_method_name = "shipping_method_name"
        case shipping_phone = "shipping_phone"
        case shipping_postal_code = "shipping_postal_code"
        case total_amount_product = "total_amount_product"
        case total_cost_befor_tax = "total_cost_befor_tax"
        case discount_amount = "discount_amount"
        case toal_cost_after_discount_and_befor_tax = "toal_cost_after_discount_and_befor_tax"
        case tax_percent = "tax_percent"
        case tax_amount = "tax_amount"
        case shipping_amount = "shipping_amount"
        case shiping_tax_percent = "shiping_tax_percent"
        case shiping_tax_amount = "shiping_tax_amount"
        case total_cost_final = "total_cost_final"
        case shipping_tax_percent = "shipping_tax_percent"
        case trans_status_id = "trans_status_id"
        case list_product = "list_product"
        case user = "user"
        case orderStatus = "order_status"
    }
   
}
