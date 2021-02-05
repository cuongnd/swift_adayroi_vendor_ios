//
//  WarehouseLabelCollectionViewCell.swift
//  AdayroiVendor
//
//  Created by cuongnd on 1/11/21.
//  Copyright © 2021 Mitesh's MAC. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class WarehouseLabelCollectionViewCell: UICollectionViewCell {
    static let reuseID = "WarehouseLabelCollectionViewCell"
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
