//
//  OrderHistoryVC.swift
//  AdayroiVendor
//
//  Created by Mitesh's MAC on 07/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import TLCustomMask
import UIKit
import SwiftyJSON
import iOSDropDown
import OpalImagePicker
import Photos
import FlexColorPicker

import Foundation
import SystemConfiguration
import Alamofire
import MBProgressHUD
import DLRadioButton

protocol AddNewProductDelegate {
    func refreshData()
}
struct ImageColorModel {
    var color_name: String
    var image: UIImage
    var color_value: UIColor
    var has_image:Int
    init(color_name:String,image:UIImage,color_value:UIColor,has_image:Int) {
        self.color_name=color_name
        self.image=image
        self.color_value=color_value
        self.has_image=has_image
    }
    var dictionary: [String: Any] {
        return ["color_name": color_name,
                "color_value": color_value.hexValue(),
                "has_image":has_image
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
struct DataUpload {
    var key_name:String
    var file_name: String
    var data:Data
    var mime_type: String
    init(key_name:String,file_name:String,data:Data,mime_type:String) {
        self.key_name=key_name
        self.file_name=file_name
        self.data=data
        self.mime_type=mime_type
    }
}



struct ImageProductModel {
    var image_description: String
    var image: UIImage
    init(image_description:String,image:UIImage) {
        self.image_description=image_description
        self.image=image
    }
    var dictionary: [String: Any] {
        return [
            "image_description": image_description
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}

struct VideoProductModel {
    var video_link: String
    var video_caption: String
    var video_image: String
    init(video_link:String,video_caption:String,video_image:String) {
        self.video_link=video_link
        self.video_caption=video_caption
        self.video_image=video_image
    }
    var dictionary: [String: Any] {
        return ["video_link": video_link,
                "video_caption": video_caption,
                "video_image": video_image]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}



struct CellHeaderAttribute {
    var title:String!
    var is_head:Bool!
    var columnType:String!
    var columnName:String!
    var list_attribute:[[CellAttribute]]=[[CellAttribute]]()
    init(title:String,is_head:Bool,columnType:String,columnName:String) {
        self.title=title
        self.is_head=is_head
        self.columnType=columnType
        self.columnName=columnName
    }
    
    func getUICollectionViewCell(collectionView: UICollectionView,indexPath:IndexPath)->UICollectionViewCell {
        if(self.is_head){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAttributeCollectionViewCell.reuseID, for: indexPath) as? HeaderAttributeCollectionViewCell
            cell!.contentLabel.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "stt"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAttributeCollectionViewCell.reuseID, for: indexPath) as? HeaderAttributeCollectionViewCell
            cell!.contentLabel.text=String(indexPath.section)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "edit"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditHeaderAttributeCollectionViewCell.reuseID, for: indexPath) as? EditHeaderAttributeCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonEdit.tag = indexPath.section
            return cell!
        }else if(!self.is_head && self.columnName == "edit_attributes"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditAttributesCollectionViewCell.reuseID, for: indexPath) as? EditAttributesCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonEdit.tag = indexPath.section
            return cell!
        }else if(!self.is_head && self.columnName == "delete"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAttributeDeleteCollectionViewCell.reuseID, for: indexPath) as? HeaderAttributeDeleteCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonDelete.tag = indexPath.section
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAttributeCollectionViewCell.reuseID, for: indexPath) as? HeaderAttributeCollectionViewCell
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
struct CellOrtherHeadAttribute {
    var title:String!
    var is_head:Bool!
    var columnType:String!
    var columnName:String!
    var list_attribute:[[CellAttribute]]=[[CellAttribute]]()
    init(title:String,is_head:Bool,columnType:String,columnName:String) {
        self.title=title
        self.is_head=is_head
        self.columnType=columnType
        self.columnName=columnName
    }
    
    func getUICollectionViewCell(collectionView: UICollectionView,indexPath:IndexPath)->UICollectionViewCell {
        if(self.is_head){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherAttributeCollectionViewCell.reuseID, for: indexPath) as? OtherAttributeCollectionViewCell
            cell!.contentLabel.text=String(self.title)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "stt"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherAttributeCollectionViewCell.reuseID, for: indexPath) as? OtherAttributeCollectionViewCell
            cell!.contentLabel.text=String(indexPath.section)
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            return cell!
        }else if(!self.is_head && self.columnName == "edit"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditOtherAttributeCollectionViewCell.reuseID, for: indexPath) as? EditOtherAttributeCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonEdit.tag = indexPath.section
            return cell!
        }else if(!self.is_head && self.columnName == "delete"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherAttributeDeleteCollectionViewCell.reuseID, for: indexPath) as? OtherAttributeDeleteCollectionViewCell
            if indexPath.section % 2 != 0 {
                cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                cell!.backgroundColor = UIColor.white
            }
            cell?.UIButtonDelete.tag = indexPath.section
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherAttributeCollectionViewCell.reuseID, for: indexPath) as? OtherAttributeCollectionViewCell
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

struct HeaderAttributeTitleModel {
    var title: String
    var note:String
    var list_attribute:[HeaderAttributeModel]=[HeaderAttributeModel]()
    init(title:String,note:String,list_attribute:[HeaderAttributeModel]) {
        self.title=title
        self.note=note
        self.list_attribute=list_attribute
    }
    
    var dictionary: [String: Any] {
        var list_attribute:[NSDictionary]=[NSDictionary]()
        if(self.list_attribute.count>0){
            for index in 0...self.list_attribute.count-1 {
                let currentItem=self.list_attribute[index]
                list_attribute.append(currentItem.nsDictionary)
                
            }
        }
        return [
            "title": title,
            "note": note,
            "list_attribute":list_attribute
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
struct HeaderAttributeModel {
    var title: String
    var price: Double
    var note:String
    init(title:String,price:Double,note:String) {
        self.title=title
        self.price=price
        self.note=note
    }
    var dictionary: [String: Any] {
        return [
            "title": title,
            "price": price,
            "note": note
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}


struct OtherHeaderAttributeTitleModel {
    var title: String
    var description:String
    var note:String
    init(title:String,description:String,note:String) {
        self.title=title
        self.description=description
        self.note=note
    }
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "description":description,
            "note": note,
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}


class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIImageViewImageUpload: UIImageView!
    @IBOutlet weak var UIButtonDeleteImage: UIButton!
    @IBOutlet weak var UILabelDescription: UILabel!
    @IBOutlet weak var UIButtonProductImageDescription: UIButton!
    static let reuseID = "ImageCollectionViewCell"
}
class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIImageViewImageUpload: UIImageView!
    @IBOutlet weak var UIButtonDeleteImage: UIButton!
    @IBOutlet weak var UILabelColorName: UILabel!
    @IBOutlet weak var UIButtonColor: UIButton!
    @IBOutlet weak var UIButtonChangeImageInCell: UIButton!
    @IBOutlet weak var UIButtonEditColorName: UIButton!
    static let reuseID = "ColorCollectionViewCell"
}
class HeaderAttributeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    static let reuseID = "HeaderAttributeCollectionViewCell"
}
class OtherAttributeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    static let reuseID = "OtherAttributeCollectionViewCell"
}
class HeaderAttributeDeleteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonDelete: UIButton!
    static let reuseID = "HeaderAttributeDeleteCollectionViewCell"
}
class OtherAttributeDeleteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonDelete: UIButton!
    static let reuseID = "OtherAttributeDeleteCollectionViewCell"
}

class EditOtherAttributeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditOtherAttributeCollectionViewCell"
}

class EditHeaderAttributeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditHeaderAttributeCollectionViewCell"
}
class EditOtherAttributesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditAttributesCollectionViewCell"
}

class EditAttributesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditAttributesCollectionViewCell"
}
class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIImageViewImageUpload: UIImageView!
    @IBOutlet weak var UIButtonDeleteImage: UIButton!
    @IBOutlet weak var UILabelDescription: UILabel!
    @IBOutlet weak var UIButtonProductImageDescription: UIButton!
    static let reuseID = "VideoCollectionViewCell"
}
class TextCollectionViewCell: UICollectionViewCell {
    static let reuseID = "TextCollectionViewCell"
}

class AddNewProductVC: UIViewController {
    
    @IBOutlet weak var btn_ok: UIButton!
    var productImageColorChanging:Int=0
    var productImageColorNameChanging:Int=0
    var productImageDescriptionChanging:Int=0
    var productHeaderAttributeChanging:Int=0
    var delegate: AddNewProductDelegate!
    @IBOutlet weak var UILabelSoTienToiDa: UILabel!
    @IBOutlet weak var UITextFieldSoTien: UITextField!
    var userAffiliateInfoModel:UserAffiliateInfoModel=UserAffiliateInfoModel()
    @IBOutlet weak var DropDownCategoriesProduct: DropDown!
    var customMask = TLCustomMask()
    var customMaskUnitPrice = TLCustomMask()
    var curentCategory:CategoryModel=CategoryModel()
    var list_category:[CategoryModel]=[CategoryModel]()
    var list_unit:[UnitModel]=[UnitModel]()
    
    var list_total_product_in_warehouse:[ProductInWarehouseModel]=[ProductInWarehouseModel]()
    
    var list_sub_category:[SubCategoryModel]=[SubCategoryModel]()
    var curentSubCategory:SubCategoryModel=SubCategoryModel()
    @IBOutlet weak var DropDownSubCategories: DropDown!
    @IBOutlet weak var UITextFieldOriginPrice: UITextField!
    @IBOutlet weak var UITextFieldUnitPrice: UITextField!
    @IBOutlet weak var UIButtonAddImage: UIButton!
    @IBOutlet weak var UIButtonAddOtherAttributeProduct: UIButton!
    @IBOutlet weak var UIButtonQlKhoHang: UIButton!
    var list_product_image:[ImageProductModel]=[ImageProductModel]()
    var list_video_link:[VideoProductModel]=[VideoProductModel]()
    var list_image_color:[ImageColorModel]=[ImageColorModel]()
    var list_header_attribute_title:[HeaderAttributeTitleModel]=[HeaderAttributeTitleModel]()
    var list_other_header_attribute_title:[OtherHeaderAttributeTitleModel]=[OtherHeaderAttributeTitleModel]()
    
    @IBOutlet weak var UICollectionViewListProductImage: UICollectionView!
    let imagePicker = UIImagePickerController()
    let multiImagePicker = OpalImagePickerController()
    let multiImageColorPicker = OpalImagePickerController()
    let headerTitlesImage = [
        DataRowModel(type: .Text, text:DataTableValueType.string("STT"),key_column: "stt",column_width: 50,column_height: 50),
        DataRowModel(type:.Text, text:DataTableValueType.string("Image"),key_column: "image",column_width: 100,column_height: 50),
        DataRowModel(type: .Text, text:DataTableValueType.string("Description"),key_column: "description",column_width: 150,column_height: 50),
        DataRowModel(type: .Text, text:DataTableValueType.string("Action"),key_column: "delete",column_width: 100,column_height: 50)
        
    ]
    var headerAttributeTitleProduct = [[
        CellHeaderAttribute(title: "Stt",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Title",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Note",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Thuộc tính",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Sửa thuộc tính",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Sửa",is_head: true,columnType: "", columnName: ""),
        CellHeaderAttribute(title: "Xóa",is_head: true,columnType: "",columnName: ""),
        
        
        ]]
    var orderheaderAttributeTitleProduct = [[
        CellOrtherHeadAttribute(title: "Stt",is_head: true,columnType: "", columnName: ""),
        CellOrtherHeadAttribute(title: "Thuộc tính",is_head: true,columnType: "", columnName: ""),
        CellOrtherHeadAttribute(title: "Nội dung",is_head: true,columnType: "", columnName: ""),
        CellOrtherHeadAttribute(title: "Sửa",is_head: true,columnType: "", columnName: ""),
        CellOrtherHeadAttribute(title: "Xóa",is_head: true,columnType: "",columnName: ""),
        
        
        ]]
    var wareHouseheadFisrtRow:[CellWareHouseHead]=[]
    var wareHousehead:[[CellWareHouseHead]] = [[CellWareHouseHead]]()
    
    @IBOutlet weak var UICollectionViewColorProducts: UICollectionView!
    var list_image_source:[[DataRowModel]]=[[DataRowModel]]()
    @IBOutlet weak var UIButtonPickupColor: UIButton!
    
    @IBOutlet weak var UICollectionViewHeaderAttributes: UICollectionView!
    
    @IBOutlet weak var UIButtonLinkVideo: UIButton!
    @IBOutlet weak var UIButtonAddHeaderAttribute: UIButton!
    @IBOutlet weak var UICollectionViewListLinkVideo: UICollectionView!
    @IBOutlet weak var UICollectionViewOtherHeadAttribute: UICollectionView!
    @IBOutlet weak var UICollectionViewWareHouses: UICollectionView!
    @IBOutlet weak var UITextFieldProductName: UITextField!
    @IBOutlet weak var UITextFieldProductCode: UITextField!
    @IBOutlet weak var UITextFieldProductLength: UITextField!
    @IBOutlet weak var UITextFieldProductWidth: UITextField!
    @IBOutlet weak var UITextFieldProductHeight: UITextField!
    @IBOutlet weak var UITextFieldProductWeight: UITextField!
    @IBOutlet weak var UITextFieldProductUnit: DropDown!
    @IBOutlet weak var UITextFieldAlias: UITextField!
    @IBOutlet weak var DropDownProductCatId: DropDown!
    @IBOutlet weak var DropDownProductSubCatId: DropDown!
    @IBOutlet weak var UITextFieldProductOrignalPrice: UITextField!
    @IBOutlet weak var UITextFieldProductUnitPrice: UITextField!
    @IBOutlet weak var UITextViewProductShortDescription: UITextView!
    @IBOutlet weak var UITextViewProductFullDescription: UITextView!
    @IBOutlet weak var UILabelmageProduct: UILabel!
    @IBOutlet var DLRadioButtonProductType : DLRadioButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nibCell = UINib(nibName:WarehouseLabelCollectionViewCell.reuseID, bundle: nil)
        self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WarehouseLabelCollectionViewCell.reuseID)
        
        nibCell = UINib(nibName:WareHouseEditCollectionViewCell.reuseID, bundle: nil)
        self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WareHouseEditCollectionViewCell.reuseID)
        
        nibCell = UINib(nibName:WareHouseDeleteCollectionViewCell.reuseID, bundle: nil)
        self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WareHouseDeleteCollectionViewCell.reuseID)
        
        
        
        
        /*
         let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
         print(" ")
         phoneFormatter.format("+123456789012") /
         */
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlGetCategories = API_URL + "/api/categories"
        self.Webservice_getCategories(url: urlGetCategories, params:[:])
        //self.UITextFieldSoTien.delegate = self
        
        DropDownCategoriesProduct.didSelect{(selectedText , index ,id) in
            self.curentCategory=self.list_category[index]
            let urlGetSubCategories = API_URL + "/api/subcategories/list?cat_id=\(self.curentCategory._id)"
            self.Webservice_getSubCategories(url: urlGetSubCategories, params:[:])
            
        }
        DropDownSubCategories.didSelect{(selectedText , index ,id) in
            self.curentSubCategory=self.list_sub_category[index]
            
            
        }
        let urlGetUnitsProduct = API_URL + "/api/units?user_id=\(user_id)"
        self.Webservice_getUnitsProduct(url: urlGetUnitsProduct, params:[:])
        
        
        /*
         let tapAddImage = UITapGestureRecognizer(target: self, action: #selector(btnTapAddImage))
         self.UIImageViewAddImage.isUserInteractionEnabled = true
         self.UIImageViewAddImage.addGestureRecognizer(tapAddImage)
         */
        
        cornerRadius(viewName: self.UIButtonAddImage, radius: self.UIButtonAddImage.frame.height / 2)
        cornerRadius(viewName: self.UIButtonAddImageColor, radius: self.UIButtonAddImageColor.frame.height / 2)
        cornerRadius(viewName: self.UIButtonPickupColor, radius: self.UIButtonPickupColor.frame.height / 2)
        cornerRadius(viewName: self.UIButtonAddHeaderAttribute, radius: self.UIButtonAddHeaderAttribute.frame.height / 2)
        cornerRadius(viewName: self.UIButtonLinkVideo, radius: self.UIButtonLinkVideo.frame.height / 2)
        cornerRadius(viewName: self.UIButtonAddOtherAttributeProduct, radius: self.UIButtonAddOtherAttributeProduct.frame.height / 2)
        
        multiImagePicker.imagePickerDelegate = self
        multiImageColorPicker.imagePickerDelegate = self
        
        
        self.UICollectionViewHeaderAttributes.delegate = self
        self.UICollectionViewHeaderAttributes.dataSource = self
        
        self.UICollectionViewOtherHeadAttribute.delegate = self
        self.UICollectionViewOtherHeadAttribute.dataSource = self
        
        self.UICollectionViewWareHouses.delegate = self
        self.UICollectionViewWareHouses.dataSource = self
        let selector = #selector(self.nothing(_:))
        self.wareHouseheadFisrtRow=[
            CellWareHouseHead(title: "Stt",is_head: true,columnType: "", columnName: "stt",action: selector),
            CellWareHouseHead(title: "Kho hàng",is_head: true,columnType: "", columnName: "",action: selector),
            CellWareHouseHead(title: "Số lượng sản phẩm",is_head: true,columnType: "", columnName: "",action: selector),
            CellWareHouseHead(title: "Sửa",is_head: true,columnType: "", columnName: "edit",action: selector)
            
            
        ]
        self.wareHousehead.append(self.wareHouseheadFisrtRow)
        let urlStringGetListWarehouse = API_URL + "/api/warehouses/get_total_product_in_warehouse_by_user_id/\(user_id)"
        let params: NSDictionary = [
            "product_id": ""
        ]
        self.Webservice_getListTotalProductInWareHouse(url: urlStringGetListWarehouse, params: params)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    @IBAction func UIButtonQLCacThuocTinh(_ sender: UIButton) {
        let qlCacThuocTinhVC = self.storyboard?.instantiateViewController(identifier: "QlCacThuocTinhVC") as! QlCacThuocTinhVC
        qlCacThuocTinhVC.modalAttributeHeadIndexDelegate = self
        qlCacThuocTinhVC.attributeHeadIndex = sender.tag
        qlCacThuocTinhVC.attributeTitleHeadIndex = sender.tag-1
        qlCacThuocTinhVC.attributeHead=self.headerAttributeTitleProduct[sender.tag]
        self.present(qlCacThuocTinhVC, animated: true, completion: nil)
    }
    
    @IBAction func UIButtonEditHeadAttribute(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Tiêu đề thuộc tính", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = ""
            textField.tag=sender.tag
            textField.text=self.headerAttributeTitleProduct[sender.tag][1].title
            //textField.isSecureTextEntry = true
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            let content=String(describing: textField.text!)
            
            self.headerAttributeTitleProduct[textField.tag][1].title=content;
            self.UICollectionViewHeaderAttributes.delegate = self
            self.UICollectionViewHeaderAttributes.dataSource = self
            self.UICollectionViewHeaderAttributes.reloadData()
            self.list_header_attribute_title[textField.tag-1].title=content
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func UIButtonDeleteHeadAtrribute(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            self.headerAttributeTitleProduct.remove(at: sender.tag)
            self.UICollectionViewHeaderAttributes.delegate = self
            self.UICollectionViewHeaderAttributes.dataSource = self
            self.UICollectionViewHeaderAttributes.reloadData()
            self.list_header_attribute_title.remove(at: sender.tag-1)
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
    }
    @IBAction func UIButtonTouchUpInsideEditImageDescriptionProduct(_ sender: UIButton) {
        self.productImageDescriptionChanging=sender.tag
        let alertController = UIAlertController(title: "Mô tả ảnh sản phẩm", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = ""
            //textField.isSecureTextEntry = true
            textField.text=self.list_product_image[self.productImageDescriptionChanging].image_description
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("Current password \(String(describing: textField.text))")
            self.list_product_image[self.productImageDescriptionChanging].image_description=String(describing: textField.text!)
            self.UICollectionViewListProductImage.delegate = self
            self.UICollectionViewListProductImage.dataSource = self
            self.UICollectionViewListProductImage.reloadData()
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonChangeImageProduct(_ sender: UIButton) {
        self.productImageColorChanging=sender.tag
        self.imagePicker.delegate = self
        let alert = UIAlertController(title: "", message: "Change Image".localiz(), preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localiz(), style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera".localiz(), style: .default) { (action) in
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel".localiz(), style: .cancel)
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonTouchUpInsideEditColorName(_ sender: UIButton) {
        self.productImageColorNameChanging=sender.tag
        let alertController = UIAlertController(title: "Màu sắc", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "màu sắc"
            //textField.isSecureTextEntry = true
            textField.text=self.list_image_color[self.productImageColorNameChanging].color_name
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("Current password \(String(describing: textField.text))")
            self.list_image_color[self.productImageColorNameChanging].color_name=String(describing: textField.text!)
            self.UICollectionViewColorProducts.delegate = self
            self.UICollectionViewColorProducts.dataSource = self
            self.UICollectionViewColorProducts.reloadData()
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonPickupColorProduct(_ sender: UIButton) {
        
        let modalSelectColorViewController = self.storyboard?.instantiateViewController(identifier: "ModalSelectColorViewController") as! ModalSelectColorViewController
        modalSelectColorViewController.modalSelectColorRutDelegate = self
        modalSelectColorViewController.pickedColor=UIColor.brown
        modalSelectColorViewController.colorIndex = -1
        self.present(modalSelectColorViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func UIButtonSelectProductColor(_ sender: UIButton) {
        let modalSelectColorViewController = self.storyboard?.instantiateViewController(identifier: "ModalSelectColorViewController") as! ModalSelectColorViewController
        modalSelectColorViewController.modalSelectColorRutDelegate = self
        modalSelectColorViewController.pickedColor=self.list_image_color[sender.tag].color_value
        modalSelectColorViewController.colorIndex=sender.tag
        self.present(modalSelectColorViewController, animated: true, completion: nil)
    }
    @IBAction func UIButtonTouchUpInsideDeleteProductImageColor(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            let imageIndex=sender.tag
            self.list_image_color.remove(at: imageIndex)
            self.UICollectionViewColorProducts.delegate = self
            self.UICollectionViewColorProducts.dataSource = self
            self.UICollectionViewColorProducts.reloadData()
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
    }
    @IBOutlet weak var UIButtonAddImageColor: UIButton!
    @IBAction func UIButtonClickAddImageColor(_ sender: UIButton) {
        self.imagePicker.delegate = self
        let alert = UIAlertController(title: "", message: "Select image color".localiz(), preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localiz(), style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.multiImageColorPicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera".localiz(), style: .default) { (action) in
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel".localiz(), style: .cancel)
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func UIButtonClickAddImage(_ sender: UIButton) {
        
        
        
        self.imagePicker.delegate = self
        let alert = UIAlertController(title: "", message: "Select image".localiz(), preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localiz(), style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.multiImagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera".localiz(), style: .default) { (action) in
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel".localiz(), style: .cancel)
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func UIButtonDeleteImage(_ sender: UIButton) {
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            let imageIndex=sender.tag
            self.list_product_image.remove(at: imageIndex)
            self.UICollectionViewListProductImage.delegate = self
            self.UICollectionViewListProductImage.dataSource = self
            self.UICollectionViewListProductImage.reloadData()
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
        
        
    }
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    var alertTextField: UITextField!
    @objc func textFieldDidChange(){
        
        if let e = alertTextField.text {
            let alertButton = alertController.actions[0]
            alertButton.isEnabled = e.trimmingCharacters(in: .whitespacesAndNewlines)=="" ? false : true
        }
    }
    var alertController:UIAlertController=UIAlertController()
    @IBAction func UIButtonTouchUpInsideAddAttributeHeader(_ sender: UIButton) {
        alertController=UIAlertController(title: "Tiêu đề thuộc tính", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            self.alertTextField = textField
            textField.placeholder = ""
            //textField.isSecureTextEntry = true
            
            textField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            let content=String(describing: textField.text!)
            if(content==""){
                return
            }
            self.headerAttributeTitleProduct.append([
                CellHeaderAttribute(title: "",is_head: false,columnType: "content", columnName: "stt"),
                CellHeaderAttribute(title: content,is_head: false,columnType: "content", columnName: "title"),
                CellHeaderAttribute(title: "",is_head: false,columnType: "content", columnName: "note"),
                CellHeaderAttribute(title: "",is_head: false,columnType: "content", columnName: "attributes"),
                CellHeaderAttribute(title: "",is_head: false,columnType: "button",columnName: "edit_attributes"),
                CellHeaderAttribute(title: "",is_head: false,columnType: "button",columnName: "edit"),
                CellHeaderAttribute(title: "",is_head: false,columnType: "button",columnName: "delete"),
                
                
            ]);
            
            
            let headerAttributeTitleModel:HeaderAttributeTitleModel=HeaderAttributeTitleModel(title: content, note: "", list_attribute: [HeaderAttributeModel]())
            self.list_header_attribute_title.append(headerAttributeTitleModel)
            self.UICollectionViewHeaderAttributes.delegate = self
            self.UICollectionViewHeaderAttributes.dataSource = self
            self.UICollectionViewHeaderAttributes.reloadData()
            
            // IMPORTANT: this is the key to make your cells auto-sizing
            if let collectionViewLayout = self.UICollectionViewHeaderAttributes.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
            //compare the current password and do action here
        }
        confirmAction.isEnabled = false
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    var alertTextFieldLinkVideo: UITextField!
    @objc func textFieldDidChangeLinkVideo(){
        
        if let e = alertTextFieldLinkVideo.text {
            let alertButton = alertController.actions[0]
            let video_link = e.trimmingCharacters(in: .whitespacesAndNewlines)
            print("video_link \(video_link)")
            print("video_link.youtubeID \(video_link.youtubeID)")
            
            if(video_link.youtubeID != nil){
                alertButton.isEnabled=true
            }
        }
    }
    @IBAction func UIButtonAddNewLinkVideo(_ sender: UIButton) {
        alertController=UIAlertController(title: "Link video youtube", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            self.alertTextFieldLinkVideo = textField
            textField.placeholder = "Link Video"
            //textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(self.textFieldDidChangeLinkVideo), for: UIControl.Event.editingChanged)
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            let video_link=String(describing: textField.text!)
            if(video_link==""){
                return
            }
            let video_image="https://img.youtube.com/vi/\(video_link.youtubeID!)/hqdefault.jpg"
            
            print("video_image \(video_image)")
            let videoProductModel:VideoProductModel=VideoProductModel(video_link: video_link, video_caption: "", video_image: video_image)
            self.list_video_link.append(videoProductModel)
            
            self.UICollectionViewListLinkVideo.delegate = self
            self.UICollectionViewListLinkVideo.dataSource = self
            self.UICollectionViewListLinkVideo.reloadData()
        }
        //compare the current password and do action here
        
        confirmAction.isEnabled = false
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonTouchUpInsideDeleteLinkVideo(_ sender: UIButton) {
    }
    @IBAction func UIButtonTouchUpInsideQLKhoHang(_ sender: UIButton) {
        let qlKhoHangVC = self.storyboard?.instantiateViewController(identifier: "QlKhoHangVC") as! QlKhoHangVC
        qlKhoHangVC.Delegate = self
        //qlKhoHangVC.attributeHeadIndex = sender.tag
        //qlKhoHangVC.attributeHead=self.headerAttributeTitleProduct[sender.tag]
        self.present(qlKhoHangVC, animated: true, completion: nil)
    }
    @IBAction func UIButtonTouchUpInsideEditLinkVideoCaption(_ sender: UIButton) {
        self.productImageDescriptionChanging=sender.tag
        let alertController = UIAlertController(title: "Mô tả video", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = ""
            //textField.isSecureTextEntry = true
            textField.tag=sender.tag
            textField.text=self.list_video_link[sender.tag].video_caption
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("video_caption \(String(describing: textField.text))")
            self.list_video_link[textField.tag].video_caption=String(describing: textField.text!)
            self.UICollectionViewListLinkVideo.delegate = self
            self.UICollectionViewListLinkVideo.dataSource = self
            self.UICollectionViewListLinkVideo.reloadData()
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func UIButtonTouchUpInsideEditAndAddNewOtherAttributeProduct(_ sender: UIButton) {
        
        let otherAttributeEditVC = self.storyboard?.instantiateViewController(identifier: "OtherAttributeEditVC") as! OtherAttributeEditVC
        otherAttributeEditVC.delegate = self
        if(sender.tag==0){
            otherAttributeEditVC.otherAttributeHeadIndex = -1
            otherAttributeEditVC.otherAttributeHead=[
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "stt"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "title"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "attributes"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "button",columnName: "edit"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "button",columnName: "delete"),
            ]
            
        }else{
            otherAttributeEditVC.otherAttributeHeadIndex = sender.tag
            otherAttributeEditVC.otherAttributeTitleHeadIndex = sender.tag-1
            otherAttributeEditVC.otherAttributeHead=self.orderheaderAttributeTitleProduct[sender.tag]
            
        }
        self.present(otherAttributeEditVC, animated: true, completion: nil)
        
        
    }
    @objc func nothing(_ sender: UIButton){
        
        
    }
    @objc func deleteWarehouse(_ sender: UIButton){
        
        
    }
    @objc func editTotalProductWarehouse(_ sender: UIButton){
        
        let editProductInWareHouseVC = self.storyboard?.instantiateViewController(identifier: "EditProductInWareHouseVC") as! EditProductInWareHouseVC
        editProductInWareHouseVC.delegate = self
        editProductInWareHouseVC.productInWarehouse = self.list_total_product_in_warehouse[sender.tag-1]
        editProductInWareHouseVC.productInWarehouseIndex = sender.tag-1
        self.present(editProductInWareHouseVC, animated: true, completion: nil)
    }
    @IBAction func UIButtonTouchUpInsideSaveProduct(_ sender: UIButton) {
        /*
         @IBOutlet weak var UITextFieldProductName: UITextField!
         @IBOutlet weak var UITextFieldProductCode: UITextField!
         @IBOutlet weak var UITextFieldProductLength: UITextField!
         @IBOutlet weak var UITextFieldProductWidth: UITextField!
         @IBOutlet weak var UITextFieldProductHeight: UITextField!
         @IBOutlet weak var UITextFieldProductWeight: UITextField!
         @IBOutlet weak var UITextFieldProductUnit: UITextField!
         @IBOutlet weak var UITextFieldAlias: UITextField!
         @IBOutlet weak var DropDownProductCatId: DropDown!
         @IBOutlet weak var DropDownProductSubCatId: DropDown!
         @IBOutlet weak var UITextFieldProductOrignalPrice: UITextField!
         @IBOutlet weak var UITextFieldProductUnitPrice: UITextField!
         @IBOutlet weak var UITextViewProductShortDescription: UITextView!
         @IBOutlet weak var UITextViewProductFullDescription: UITextView!
         */
        var product_name=String(self.UITextFieldProductName.text!)
        product_name = String(product_name.filter { !" \n\t\r".contains($0) })
        if(product_name==""){
            UITextFieldProductName.text="";
            UITextFieldProductName.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_code=String(self.UITextFieldProductCode.text!)
        product_code = String(product_code.filter { !" \n\t\r".contains($0) })
        
        if(product_code==""){
            UITextFieldProductCode.text="";
            UITextFieldProductCode.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập mã sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_length=String(self.UITextFieldProductLength.text!)
        product_length = String(product_length.filter { !" \n\t\r".contains($0) })
        if(product_length != "" && !product_length.isNumber){
            UITextFieldProductLength.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_height=String(self.UITextFieldProductHeight.text!)
        product_height = String(product_height.filter { !" \n\t\r".contains($0) })
        if(product_height != "" &&  !product_height.isNumber){
            UITextFieldProductHeight.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        var product_width=String(self.UITextFieldProductWidth.text!)
        product_width = String(product_width.filter { !" \n\t\r".contains($0) })
        if(product_width != "" &&   !product_width.isNumber){
            UITextFieldProductWidth.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_weight=String(self.UITextFieldProductWeight.text!)
        product_weight = String(product_weight.filter { !" \n\t\r".contains($0) })
        if(product_weight==""){
            UITextFieldProductWeight.text="";
            UITextFieldProductWeight.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập trọng lượng sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(!product_weight.isNumber){
            UITextFieldProductWeight.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        var product_unit=String(self.UITextFieldProductUnit.text!)
        product_unit = String(product_unit.filter { !" \n\t\r".contains($0) })
        
        if(product_unit==""){
            UITextFieldProductUnit.text="";
            UITextFieldProductUnit.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đơn vị đo sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_alias=String(self.UITextFieldAlias.text!)
        product_alias = String(product_alias.filter { !" \n\t\r".contains($0) })
        if(product_alias==""){
            UITextFieldAlias.text="";
            UITextFieldAlias.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập link seo sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_orignal_price=String(self.UITextFieldProductOrignalPrice.text!)
        product_orignal_price = String(product_orignal_price.filter { !" \n\t\r".contains($0) })
        if(product_orignal_price==""){
            UITextFieldProductOrignalPrice.text="";
            UITextFieldProductOrignalPrice.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập giá thường bán ngoài thị trường", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(!product_orignal_price.isNumber){
            UITextFieldProductOrignalPrice.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_unit_price=String(self.UITextFieldProductUnitPrice.text!)
        product_unit_price = String(product_unit_price.filter { !" \n\t\r".contains($0) })
        if(product_unit_price==""){
            UITextFieldProductUnitPrice.text="";
            UITextFieldProductUnitPrice.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập giá giá bán của bạn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if(!product_unit_price.isNumber){
            UITextFieldProductUnitPrice.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        var product_short_description=String(self.UITextViewProductShortDescription.text!)
        product_short_description = String(product_short_description.filter { !" \n\t\r".contains($0) })
        if(product_short_description==""){
            UITextViewProductShortDescription.text="";
            UITextViewProductShortDescription.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập mô tả ngắn về sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        var product_full_description=String(self.UITextViewProductFullDescription.text!)
        product_full_description = String(product_full_description.filter { !" \n\t\r".contains($0) })
        
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId)
        
        if(self.curentCategory._id==""){
            DropDownCategoriesProduct.text="";
            DropDownCategoriesProduct.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn nhóm sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if(self.curentSubCategory._id==""){
            DropDownSubCategories.text="";
            DropDownSubCategories.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn nhóm sản phẩm con", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        //product image
        var listImageProductCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringImageProduct:String=""
        if(self.list_product_image.count>0){
            for index in 0...self.list_product_image.count-1 {
                let currentItem=self.list_product_image[index]
                listImageProductCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonData: NSData
            do {
                jsonData = try JSONSerialization.data(withJSONObject: listImageProductCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringImageProduct = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập ảnh sản phẩm", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        //video product
        var listVideoLinkCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringVideoLink:String=""
        if(self.list_video_link.count>0){
            for index in 0...self.list_video_link.count-1 {
                let currentItem=self.list_video_link[index]
                listVideoLinkCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonDataVideoLink: NSData
            do {
                jsonDataVideoLink = try JSONSerialization.data(withJSONObject: listVideoLinkCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringImageProduct = NSString(data: jsonDataVideoLink as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
        }
        //product in ware house
        var listTotalProductInWarehouseCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringjsonDataTotalProductInWarehouse:String=""
        if(self.list_total_product_in_warehouse.count>0){
            for index in 0...self.list_total_product_in_warehouse.count-1 {
                let currentItem=self.list_total_product_in_warehouse[index]
                listTotalProductInWarehouseCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonDataTotalProductInWarehouse: NSData
            do {
                jsonDataTotalProductInWarehouse = try JSONSerialization.data(withJSONObject: listTotalProductInWarehouseCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringjsonDataTotalProductInWarehouse = NSString(data: jsonDataTotalProductInWarehouse as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số lượng sản phẩm trong các kho hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        //
        var listHeaderAttributeTitleCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringHeaderAttributeTitle:String=""
        if(self.list_header_attribute_title.count>0){
            for index in 0...self.list_header_attribute_title.count-1 {
                let currentItem=self.list_header_attribute_title[index]
                listHeaderAttributeTitleCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonDataHeaderAttributeTitle: NSData
            do {
                jsonDataHeaderAttributeTitle = try JSONSerialization.data(withJSONObject: listHeaderAttributeTitleCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringHeaderAttributeTitle = NSString(data: jsonDataHeaderAttributeTitle as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
        }
        //list_other_header_attribute_title
        
        var listOtherHeaderAttributeTitleCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringOtherHeaderAttributeTitle:String=""
        if(self.list_other_header_attribute_title.count>0){
            for index in 0...self.list_other_header_attribute_title.count-1 {
                let currentItem=self.list_other_header_attribute_title[index]
                listOtherHeaderAttributeTitleCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonDataOtherHeaderAttributeTitle: NSData
            do {
                jsonDataOtherHeaderAttributeTitle = try JSONSerialization.data(withJSONObject: listOtherHeaderAttributeTitleCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringOtherHeaderAttributeTitle = NSString(data: jsonDataOtherHeaderAttributeTitle as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
        }
        
        //list image color product
        
        var listImageColorCodableDict = [NSDictionary]() // or [String:AnyCodable]()
        var jsonStringImageColor:String=""
        if(self.list_image_color.count>0){
            for index in 0...self.list_image_color.count-1 {
                let currentItem=self.list_image_color[index]
                listImageColorCodableDict.append(currentItem.nsDictionary)
                
            }
            let jsonDataImageColor: NSData
            do {
                jsonDataImageColor = try JSONSerialization.data(withJSONObject: listImageColorCodableDict, options: JSONSerialization.WritingOptions()) as NSData
                jsonStringImageColor = NSString(data: jsonDataImageColor as Data, encoding: String.Encoding.utf8.rawValue) as! String
                
            } catch _ {
                print ("JSON Failure")
            }
        }
        
        
        let parameters: [String : Any] = [
            "productTitle": product_name,
            "cat_id":self.curentCategory._id,
            "sub_cat_id":self.curentSubCategory._id,
            "shop_category_id":"",
            "shop_sub_category_id":"",
            "code": product_code,
            "length": product_length,
            "height": product_height,
            "width": product_width,
            "weight": product_weight,
            "product_unit": product_unit,
            "alias": product_alias,
            "original_price": product_orignal_price,
            "unit_price": product_unit_price,
            "productShortDescription": product_short_description,
            "productFullDescription": product_full_description,
            "list_product_image":jsonStringImageProduct,
            "list_video_link":jsonStringVideoLink,
            "list_total_product_in_warehouse":jsonStringjsonDataTotalProductInWarehouse,
            "list_header_attribute_title":jsonStringHeaderAttributeTitle,
            "list_other_header_attribute_title":jsonStringOtherHeaderAttributeTitle,
            "list_image_color":jsonStringImageColor
        ]
        let urlStringPostAddNewProduct = API_URL + "/api_task/product.add_product?user_id=\(user_id)"
        
        var list_DataUpload:[DataUpload]=[DataUpload]()
        if(self.list_product_image.count>0){
            for index in 0...self.list_product_image.count-1 {
                let currentItem=self.list_product_image[index]
                let image_name = randomString(length: 8)
                let datUpload:DataUpload=DataUpload(key_name: "image_product", file_name: image_name, data: currentItem.image.jpegData(compressionQuality: 0.8)!, mime_type: "image/jpeg")
                list_DataUpload.append(datUpload)
                
            }
            
        }
        if(self.list_image_color.count>0){
            for index in 0...self.list_image_color.count-1 {
                let currentItem=self.list_image_color[index]
                let image_name = randomString(length: 8)
                let datUpload:DataUpload=DataUpload(key_name: "image_product_color", file_name: image_name, data: currentItem.image.jpegData(compressionQuality: 0.8)!, mime_type: "image/jpeg")
                list_DataUpload.append(datUpload)
                
            }
            
        }
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn lưu sản phẩm này không ?".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
            WebServices().multipartWebServiceUploadProduct(method:.post, URLString:urlStringPostAddNewProduct, encoding:JSONEncoding.default, parameters:parameters, fileData:list_DataUpload, fileUrl:nil, headers:headers) { (response, error) in
                
                
            }
            
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
        
        
        
        
        
        
    }
    @IBAction func UIButtonDeleteOtherAttribute(_ sender: UIButton) {
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            self.orderheaderAttributeTitleProduct.remove(at: sender.tag)
            self.UICollectionViewOtherHeadAttribute.delegate = self
            self.UICollectionViewOtherHeadAttribute.dataSource = self
            self.UICollectionViewOtherHeadAttribute.reloadData()
            self.list_other_header_attribute_title.remove(at: sender.tag-1)
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
    }
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    
    
    
    
    
}



//MARK: WithdrawalList
extension AddNewProductVC {
    
    
    func Webservice_getSubCategories(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseSubCategoryModel = try jsonDecoder.decode(GetApiResponseSubCategoryModel.self, from: jsonResponse!)
                    if(getApiResponseSubCategoryModel.result=="success"){
                        
                        self.list_sub_category=getApiResponseSubCategoryModel.list_sub_category
                        self.DropDownSubCategories.text=""
                        self.DropDownSubCategories.optionArray.removeAll();
                        for index in 0...self.list_sub_category.count-1 {
                            let currentItem=self.list_sub_category[index]
                            self.DropDownSubCategories.optionArray.append(currentItem.name)
                            self.DropDownSubCategories.optionIds?.insert(index, at: index)
                        }
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    func Webservice_getUpdateProduct(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseAddNewProductModel = try jsonDecoder.decode(GetApiResponseAddNewProductModel.self, from: jsonResponse!)
                    if(getApiResponseAddNewProductModel.result=="success"){
                        
                        
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    
    
    func Webservice_getCategories(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseCategoryModel = try jsonDecoder.decode(GetApiResponseCategoryModel.self, from: jsonResponse!)
                    if(getApiResponseCategoryModel.result=="success"){
                        
                        self.list_category=getApiResponseCategoryModel.list_category
                        
                        
                        for index in 0...self.list_category.count-1 {
                            let currentItem=self.list_category[index]
                            self.DropDownCategoriesProduct.optionArray.append(currentItem.name)
                            self.DropDownCategoriesProduct.optionIds?.insert(index, at: index)
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    
    func Webservice_getUnitsProduct(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseUnitsProductModel = try jsonDecoder.decode(GetApiResponseUnitsProductModel.self, from: jsonResponse!)
                    if(getApiResponseUnitsProductModel.result=="success"){
                        
                        self.list_unit=getApiResponseUnitsProductModel.list_unit
                        self.UITextFieldProductUnit.text=""
                        self.UITextFieldProductUnit.optionArray.removeAll();
                        if(self.list_unit.count>0){
                            for index in 0...self.list_unit.count-1 {
                                let currentItem=self.list_unit[index]
                                self.UITextFieldProductUnit.optionArray.append(currentItem.name)
                                self.UITextFieldProductUnit.optionIds?.insert(index, at: index)
                            }
                        }
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    func Webservice_getListTotalProductInWareHouse(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseProductInWarehousesModel = try jsonDecoder.decode(GetApiResponseProductInWarehousesModel.self, from: jsonResponse!)
                    if(getApiResponseProductInWarehousesModel.result=="success"){
                        
                        let list_total_product_in_warehouse_old=self.list_total_product_in_warehouse
                        self.list_total_product_in_warehouse=getApiResponseProductInWarehousesModel.list_product_in_warehouse
                        for i in 0..<self.list_total_product_in_warehouse.count
                        {
                            for j in 0..<list_total_product_in_warehouse_old.count
                            {
                                if(self.list_total_product_in_warehouse[i]._id == list_total_product_in_warehouse_old[j]._id){
                                    self.list_total_product_in_warehouse[i].total_product=list_total_product_in_warehouse_old[j].total_product
                                    self.list_total_product_in_warehouse[i].unlimit=list_total_product_in_warehouse_old[j].unlimit
                                }
                            }
                        }
                        self.wareHousehead.removeAll()
                        self.wareHousehead.append(self.wareHouseheadFisrtRow)
                        for i in 0..<self.list_total_product_in_warehouse.count
                        {
                            let productInWarehouse:ProductInWarehouseModel=self.list_total_product_in_warehouse[i];
                            let text_total:String=productInWarehouse.unlimit == 1 ? "không giới hạn":String(productInWarehouse.total_product)
                            self.wareHousehead.append([
                                CellWareHouseHead(title: "Stt",is_head: false,columnType: "", columnName: "stt",action:  #selector(self.nothing(_:))),
                                CellWareHouseHead(title: productInWarehouse.warehouse_name,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                                CellWareHouseHead(title: text_total,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                                CellWareHouseHead(title: "Sửa",is_head: false,columnType: "", columnName: "edit",action:  #selector(self.editTotalProductWarehouse(_:)))
                            ])
                            
                        }
                        
                        self.UICollectionViewWareHouses.delegate = self
                        self.UICollectionViewWareHouses.dataSource = self
                        self.UICollectionViewWareHouses.reloadData()
                        
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
}
extension AddNewProductVC: UITextFieldDelegate{
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        self.UITextFieldOriginPrice.text = customMask.formatStringWithRange(range: range, string: string)
        self.UITextFieldUnitPrice.text = customMaskUnitPrice.formatStringWithRange(range: range, string: string)
        
        return false
    }
}
extension AddNewProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.list_image_color[self.productImageColorChanging].image=pickedImage
            //self.img_Profile.image = pickedImage
        }
        self.UICollectionViewColorProducts.delegate = self
        self.UICollectionViewColorProducts.dataSource = self
        self.UICollectionViewColorProducts.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddNewProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView==self.UICollectionViewListProductImage){
            return 1
        }else if(collectionView==self.UICollectionViewOtherHeadAttribute){
            return self.orderheaderAttributeTitleProduct.count
        }else if(collectionView==self.UICollectionViewHeaderAttributes){
            print("self.headerAttributeTitleProduct.count:\(self.headerAttributeTitleProduct.count)")
            return self.headerAttributeTitleProduct.count
        }else if(collectionView==self.UICollectionViewWareHouses){
            return self.wareHousehead.count
        }
        else{
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==self.UICollectionViewListProductImage){
            return self.list_product_image.count
        }else if(collectionView==self.UICollectionViewListLinkVideo){
            return self.list_video_link.count
        }else if(collectionView==self.UICollectionViewOtherHeadAttribute){
            return self.orderheaderAttributeTitleProduct[0].count
        }else if(collectionView==self.UICollectionViewWareHouses){
            return self.wareHousehead[0].count
        }else if(collectionView==self.UICollectionViewHeaderAttributes){
            print("self.headerAttributeTitleProduct.count:\(self.headerAttributeTitleProduct.count)")
            return self.headerAttributeTitleProduct[0].count
        }
        else{
            return self.list_image_color.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==self.UICollectionViewListProductImage){
            let uIimage:UIImage=self.list_product_image[indexPath.row].image
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseID, for: indexPath) as? ImageCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.UIImageViewImageUpload.image=uIimage
            cell.UIButtonDeleteImage.tag=indexPath.row
            cell.UILabelDescription.text=self.list_product_image[indexPath.row].image_description
            cell.UIButtonProductImageDescription.tag=indexPath.row
            cornerRadius(viewName: cell.UIButtonDeleteImage, radius: cell.UIButtonDeleteImage.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonProductImageDescription, radius: cell.UIButtonProductImageDescription.frame.height / 2)
            
            //cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white
            return cell
        }else if(collectionView==self.UICollectionViewListLinkVideo){
            let video_image:String=self.list_video_link[indexPath.row].video_image
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseID, for: indexPath) as? VideoCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.UIImageViewImageUpload.sd_setImage(with: URL(string: video_image), placeholderImage: UIImage(named: "placeholder_image"))
            
            cell.UIButtonDeleteImage.tag=indexPath.row
            cell.UILabelDescription.text=self.list_video_link[indexPath.row].video_caption
            cell.UIButtonProductImageDescription.tag=indexPath.row
            cornerRadius(viewName: cell.UIButtonDeleteImage, radius: cell.UIButtonDeleteImage.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonProductImageDescription, radius: cell.UIButtonProductImageDescription.frame.height / 2)
            
            //cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white
            return cell
            
        }else if(collectionView==self.UICollectionViewOtherHeadAttribute){
            // swiftlint:disable force_cast
            let cellOrtherHeadAttribute:CellOrtherHeadAttribute=self.orderheaderAttributeTitleProduct[indexPath.section][indexPath.row]
            let cell  = cellOrtherHeadAttribute.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
            return cell
        }else if(collectionView==self.UICollectionViewHeaderAttributes){
            // swiftlint:disable force_cast
            
            
            let cellHeaderAttribute:CellHeaderAttribute=self.headerAttributeTitleProduct[indexPath.section][indexPath.row]
            let cell  = cellHeaderAttribute.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
            return cell
        }else if(collectionView==self.UICollectionViewWareHouses){
            let cellWareHouseHead:CellWareHouseHead=self.wareHousehead[indexPath.section][indexPath.row]
            let cell  = cellWareHouseHead.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
            return cell
        }else{
            let uIimage:UIImage=self.list_image_color[indexPath.row].image
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseID, for: indexPath) as? ColorCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.UIImageViewImageUpload.image=uIimage
            cell.UIButtonDeleteImage.tag=indexPath.row
            cell.UIButtonColor.tag=indexPath.row
            cell.UIButtonChangeImageInCell.tag=indexPath.row
            cell.UIButtonEditColorName.tag=indexPath.row
            cell.UIButtonColor.tintColor=self.list_image_color[indexPath.row].color_value
            cell.UILabelColorName.text=String(self.list_image_color[indexPath.row].color_name)
            cornerRadius(viewName: cell.UIButtonDeleteImage, radius: cell.UIButtonDeleteImage.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonColor, radius: cell.UIButtonColor.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonChangeImageInCell, radius: cell.UIButtonChangeImageInCell.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonEditColorName, radius: cell.UIButtonEditColorName.frame.height / 2)
            
            
            //cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white
            return cell
        }
        
        
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("hello CGSize")
        if(collectionView==self.UICollectionViewListProductImage){
            return CGSize(width:(UIScreen.main.bounds.width-26)/2, height: 250)
        }else if(collectionView==self.UICollectionViewListLinkVideo){
            return CGSize(width:(UIScreen.main.bounds.width-26)/2, height: 250)
        }else if(collectionView==self.UICollectionViewHeaderAttributes){
            return CGSize(width:300, height: 40)
        }else if(collectionView==self.UICollectionViewHeaderAttributes){
            print("hello343434")
            return CGSize(width:300, height: 40)
        }else if(collectionView==self.UICollectionViewWareHouses){
            return CGSize(width:300, height: 40)
        }else{
            return CGSize(width:(UIScreen.main.bounds.width-26)/3, height: 128)
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         let vc = storyBoardProduct.instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsVC
         vc.itemsId = data["_id"].stringValue
         vc.SubCategoryId = data["sub_cat_id"].stringValue
         self.navigationController?.pushViewController(vc, animated: true)
         */
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
extension AddNewProductVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages assets: [UIImage]) {
        if(picker==self.multiImagePicker){
            //Save Images, update UI
            for i in 0..<assets.count
            {
                let imageProductModel:ImageProductModel=ImageProductModel(image_description: "", image: assets[i])
                self.list_product_image.append(imageProductModel)
            }
            
            
            
            
            
            self.UICollectionViewListProductImage.delegate = self
            self.UICollectionViewListProductImage.dataSource = self
            self.UICollectionViewListProductImage.reloadData()
            //Dismiss Controller
        }else if(picker==self.multiImageColorPicker){
            //Save Images, update UI
            for i in 0..<assets.count
            {
                let imageColorModel:ImageColorModel=ImageColorModel(color_name: "", image: assets[i], color_value: UIColor.brown,has_image: 1)
                self.list_image_color.append(imageColorModel)
            }
            
            
            self.UICollectionViewColorProducts.delegate = self
            self.UICollectionViewColorProducts.dataSource = self
            self.UICollectionViewColorProducts.reloadData()
        }
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
}

extension AddNewProductVC: ModalAttributeHeadIndexDelegate {
    func refreshData(AttributeHeadIndex: Int,attributeTitleHeadIndex:Int, CellAttributeList: [[CellAttribute]]) {
        var list_attribute:[String]=[String]()
        for i in 0..<CellAttributeList.count
        {
            let title:String=CellAttributeList[i][1].title!
            let price:String=CellAttributeList[i][2].title!
            list_attribute.append("\(title)(\(price))");
            self.list_header_attribute_title[attributeTitleHeadIndex].list_attribute.append(HeaderAttributeModel(title: title, price: 2.2, note: ""))
        }
        let joined2 = list_attribute.joined(separator: ", ")
        self.headerAttributeTitleProduct[AttributeHeadIndex][3].title=joined2
        self.headerAttributeTitleProduct[AttributeHeadIndex][3].list_attribute=CellAttributeList
        self.UICollectionViewHeaderAttributes.delegate = self
        self.UICollectionViewHeaderAttributes.dataSource = self
        self.UICollectionViewHeaderAttributes.reloadData()
        
        
    }
    
    
}

extension AddNewProductVC: QLKhoHangVCDelegate {
    func refreshData(AttributeHeadIndex: Int, CellKhoHangList: [[CellWareHouseHeadManager]]) {
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlStringGetListWarehouse = API_URL + "/api/warehouses/get_total_product_in_warehouse_by_user_id/\(user_id)"
        let params: NSDictionary = [
            "product_id": ""
        ]
        self.Webservice_getListTotalProductInWareHouse(url: urlStringGetListWarehouse, params: params)
        
    }
    
    
    
    
}

extension AddNewProductVC: EditProductInWareHouseVCEditDelegate {
    func refreshData(productInWarehouseIndex: Int, productInWarehouse: ProductInWarehouseModel) {
        self.list_total_product_in_warehouse[productInWarehouseIndex]=productInWarehouse
        let text_total:String=productInWarehouse.unlimit == 1 ? "không giới hạn":String(productInWarehouse.total_product)
        self.wareHousehead[productInWarehouseIndex]=[
            CellWareHouseHead(title: "Stt",is_head: false,columnType: "", columnName: "stt",action:  #selector(self.nothing(_:))),
            CellWareHouseHead(title: productInWarehouse.warehouse_name,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellWareHouseHead(title: text_total,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellWareHouseHead(title: "Sửa",is_head: false,columnType: "", columnName: "edit",action:  #selector(self.editTotalProductWarehouse(_:))),
        ]
        self.UICollectionViewWareHouses.delegate = self
        self.UICollectionViewWareHouses.dataSource = self
        self.UICollectionViewWareHouses.reloadData()
    }
    
    
    
    
    
    
}

extension AddNewProductVC: OtherAttributeEditDelegate {
    func refreshData(otherAttributeHeadIndex: Int,otherAttributeTitleHeadIndex:Int, otherAttributeHead: [CellOrtherHeadAttribute]) {
        if(otherAttributeHeadIndex == -1){
            self.orderheaderAttributeTitleProduct.append(otherAttributeHead);
            self.list_other_header_attribute_title.append(OtherHeaderAttributeTitleModel(title:otherAttributeHead[1].title ,description: otherAttributeHead[2].title, note: ""))
        }else{
            self.orderheaderAttributeTitleProduct[otherAttributeHeadIndex]=otherAttributeHead
            self.list_other_header_attribute_title[otherAttributeTitleHeadIndex].title=otherAttributeHead[1].title
            self.list_other_header_attribute_title[otherAttributeTitleHeadIndex].description=otherAttributeHead[2].title
        }
        
        self.UICollectionViewOtherHeadAttribute.delegate = self
        self.UICollectionViewOtherHeadAttribute.dataSource = self
        self.UICollectionViewOtherHeadAttribute.reloadData()
    }
    
    
    
    
}
extension AddNewProductVC: ModalSelectColorRutDelegate {
    func refreshData(colorIndex:Int,color: UIColor) {
        if(colorIndex == -1){
            let no_image  = UIImage(named: "placeholder_image")!
            let imageColorModel:ImageColorModel=ImageColorModel(color_name: "", image:no_image, color_value: color,has_image: 0)
            self.list_image_color.append(imageColorModel)
        }else{
            self.list_image_color[colorIndex].color_value=color
            
        }
        self.UICollectionViewColorProducts.delegate = self
        self.UICollectionViewColorProducts.dataSource = self
        self.UICollectionViewColorProducts.reloadData()
        
    }
    
    
}
extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}

