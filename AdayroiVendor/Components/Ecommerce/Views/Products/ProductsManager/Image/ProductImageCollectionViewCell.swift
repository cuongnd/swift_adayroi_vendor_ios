//
//  ProductImageCollectionViewCell.swift
//  AdayroiVendor
//
//  Created by cuongnd on 1/14/21.
//  Copyright © 2021 Mitesh's MAC. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class ProductImageCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ProductImageCollectionViewCell"
    @IBOutlet weak var UIImageViewProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
