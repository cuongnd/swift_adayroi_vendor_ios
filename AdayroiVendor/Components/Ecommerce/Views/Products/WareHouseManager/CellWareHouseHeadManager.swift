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
struct CellWareHouseHeadManager {
    var title:String
    var is_head:Bool
    var columnType:String
    var columnName:String
    var event:ObjectiveC
    init(title:String,is_head:Bool,columnType:String,columnName:String,event:ObjectiveC) {
        self.title=title
        self.is_head=is_head
        self.columnType=columnType
        self.columnName=columnName
        self.event=event
    }
    
    func getUICollectionViewCell(collectionView: UICollectionView,indexPath:IndexPath)->UICollectionViewCell {
        if(self.is_head){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WarehouseManagerLabelCollectionViewCell.reuseID, for: indexPath) as? WarehouseManagerLabelCollectionViewCell
            cell!.contentLabel.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "stt"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WarehouseManagerLabelCollectionViewCell.reuseID, for: indexPath) as? WarehouseManagerLabelCollectionViewCell
            cell!.contentLabel.text=String(indexPath.section)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "edit"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WareHouseManagerEditCollectionViewCell.reuseID, for: indexPath) as? WareHouseManagerEditCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonEdit.tag = indexPath.section
            return cell!
        }else if(!self.is_head && self.columnName == "delete"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WareHouseManagerDeleteCollectionViewCell.reuseID, for: indexPath) as? WareHouseManagerDeleteCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonDelete.tag = indexPath.section
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WarehouseManagerLabelCollectionViewCell.reuseID, for: indexPath) as? WarehouseManagerLabelCollectionViewCell
            cell!.contentLabel.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }
    }
}
