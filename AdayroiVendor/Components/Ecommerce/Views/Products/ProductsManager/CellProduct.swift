//
//  CellWareHouseHead.swift
//  AdayroiVendor
//
//  Created by cuongnd on 1/11/21.
//  Copyright © 2021 Mitesh's MAC. All rights reserved.
//

import TLCustomMask
import UIKit
import SwiftyJSON
import iOSDropDown
import OpalImagePicker
import Photos
import FlexColorPicker
@available(iOS 13.0, *) struct CellProduct {
    var title:String
    var is_head:Bool
    var columnType:String
    var columnName:String
    var action:Selector
    init(title:String,is_head:Bool,columnType:String,columnName:String,action: Selector) {
        self.title=title
        self.is_head=is_head
        self.columnType=columnType
        self.columnName=columnName
        self.action=action
    }
   
    
    func getUICollectionViewCell(collectionView: UICollectionView,indexPath:IndexPath)->UICollectionViewCell {
        if(self.is_head){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductShowContentCollectionViewCell.reuseID, for: indexPath) as? ProductShowContentCollectionViewCell
            cell!.UILabelContent.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "stt"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductShowContentCollectionViewCell.reuseID, for: indexPath) as? ProductShowContentCollectionViewCell
            cell!.UILabelContent.text=String(indexPath.section)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "edit"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductEditCollectionViewCell.reuseID, for: indexPath) as? ProductEditCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonEditProduct.tag = indexPath.section
            cell?.UIButtonEditProduct.addTarget(self, action: self.action, for: .touchUpInside)
            return cell!
        }else if(!self.is_head && self.columnName == "delete"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDeleteCollectionViewCell.reuseID, for: indexPath) as? ProductDeleteCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonDeleteProduct.tag = indexPath.section
            cell?.UIButtonDeleteProduct.addTarget(self, action: self.action, for: .touchUpInside)

            return cell!
        }else if(!self.is_head && self.columnName == "image"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCollectionViewCell.reuseID, for: indexPath) as? ProductImageCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIImageViewProductImage.sd_setImage(with: URL(string: self.title), placeholderImage: UIImage(named: "placeholder_image"))

            //cell?.UIImageViewProductImage.addTarget(self, action: self.action, for: .touchUpInside)

            return cell!

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductShowContentCollectionViewCell.reuseID, for: indexPath) as? ProductShowContentCollectionViewCell
            cell!.UILabelContent.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }
    }
}
