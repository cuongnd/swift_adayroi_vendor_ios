//
//  CellWidthHeightMyProduct.swift
//  AdayroiVendor
//
//  Created by cuongnd on 1/14/21.
//  Copyright © 2021 Mitesh's MAC. All rights reserved.
//

import Foundation
@available(iOS 13.0, *) struct CellWidthHeightMyProduct {
    var width:[Int]
    var headHeight:Int
    var bodyHeight:Int
    init(width:[Int],headHeight:Int,bodyHeight:Int) {
           self.width=width
           self.headHeight=headHeight
        self.bodyHeight=bodyHeight
       }
}
