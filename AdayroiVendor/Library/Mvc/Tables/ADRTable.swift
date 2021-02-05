//
//  ADRTable.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/5/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
@available(iOS 13.0, *)
class ADRTable{
   
    public init(){
       
       
    }
    static  func getTable(tableName:String) ->ADRTable {
        let cart = ADRTableCart()
        return cart
    }
    func toString(cart:Row) {
        
    }
   
    
    
}
