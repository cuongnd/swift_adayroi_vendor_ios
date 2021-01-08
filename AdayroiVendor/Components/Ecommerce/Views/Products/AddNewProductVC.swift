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


protocol AddNewProductDelegate {
    func refreshData()
}
struct ImageColorModel {
    var color_name: String
    var image: UIImage
    var color_value: UIColor
    init(color_name:String,image:UIImage,color_value:UIColor) {
        self.color_name=color_name
        self.image=image
        self.color_value=color_value
    }
}

struct ImageProductModel {
    var image_description: String
    var image: UIImage
    init(image_description:String,image:UIImage) {
        self.image_description=image_description
        self.image=image
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

struct HeaderAttributeModel {
    var title: String
    var price: Double
    var note:String
    init(title:String,price:Double,note:String) {
        self.title=title
        self.price=price
        self.note=note
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
    var list_category:[CategoryModel]=[CategoryModel]()
    var list_sub_category:[SubCategoryModel]=[SubCategoryModel]()
    var curentSubCategory:SubCategoryModel=SubCategoryModel()
    @IBOutlet weak var DropDownSubCategories: DropDown!
    @IBOutlet weak var UITextFieldOriginPrice: UITextField!
    @IBOutlet weak var UITextFieldUnitPrice: UITextField!
    @IBOutlet weak var UIButtonAddImage: UIButton!
    @IBOutlet weak var UIButtonAddOtherAttributeProduct: UIButton!
    var list_product_image:[ImageProductModel]=[ImageProductModel]()
    var list_video_link:[VideoProductModel]=[VideoProductModel]()
    var list_image_color:[ImageColorModel]=[ImageColorModel]()
    var list_header_attribute:[HeaderAttributeModel]=[HeaderAttributeModel]()
    
    
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
           CellOrtherHeadAttribute(title: "Title",is_head: true,columnType: "", columnName: ""),
           CellOrtherHeadAttribute(title: "Note",is_head: true,columnType: "", columnName: ""),
           CellOrtherHeadAttribute(title: "Thuộc tính",is_head: true,columnType: "", columnName: ""),
           CellOrtherHeadAttribute(title: "Sửa",is_head: true,columnType: "", columnName: ""),
           CellOrtherHeadAttribute(title: "Xóa",is_head: true,columnType: "",columnName: ""),
           
           
           ]]
       
    @IBOutlet weak var UICollectionViewColorProducts: UICollectionView!
    var list_image_source:[[DataRowModel]]=[[DataRowModel]]()
    @IBOutlet weak var UIButtonPickupColor: UIButton!
    
    @IBOutlet weak var UICollectionViewHeaderAttributes: UICollectionView!
    
    @IBOutlet weak var UIButtonLinkVideo: UIButton!
    @IBOutlet weak var UIButtonAddHeaderAttribute: UIButton!
    @IBOutlet weak var UICollectionViewListLinkVideo: UICollectionView!
    @IBOutlet weak var UICollectionViewOtherHeadAttribute: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            var curentCategory:CategoryModel=self.list_category[index]
            let urlGetSubCategories = API_URL + "/api/subcategories/list?cat_id=\(curentCategory._id)"
            self.Webservice_getSubCategories(url: urlGetSubCategories, params:[:])
            
        }
        DropDownSubCategories.didSelect{(selectedText , index ,id) in
            self.curentSubCategory=self.list_sub_category[index]
            
            
        }
        customMask.formattingPattern = "$$$ $$$ $$$ $$$ đ"
        customMaskUnitPrice.formattingPattern = "$$$ $$$ $$$ $$$ đ"
        self.UITextFieldOriginPrice.delegate = self
        self.UITextFieldUnitPrice.delegate = self
        
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
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    @IBAction func UIButtonQLCacThuocTinh(_ sender: UIButton) {
        let qlCacThuocTinhVC = self.storyboard?.instantiateViewController(identifier: "QlCacThuocTinhVC") as! QlCacThuocTinhVC
        qlCacThuocTinhVC.modalAttributeHeadIndexDelegate = self
        qlCacThuocTinhVC.attributeHeadIndex = sender.tag
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
    
    
    @IBAction func btnTap_Ok(_ sender: UIButton) {
        var amount=String(self.UITextFieldSoTien.text!)
        amount = String(amount.filter { !" \n\t\r".contains($0) })
        
        
        
        if(amount==""){
            UITextFieldSoTien.text="";
            UITextFieldSoTien.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số Số tiền", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(!amount.isNumber){
            UITextFieldSoTien.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if((amount as NSString).floatValue < 200000){
            
            UITextFieldSoTien.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số Số tiền lớn hơn 200 000 ngàn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        let allowWithdrawal=self.userAffiliateInfoModel.total-self.userAffiliateInfoModel.total_processing;
        
        if((amount as NSString).floatValue > allowWithdrawal){
            
            UITextFieldSoTien.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số Số tiền không lớn hơn \(allowWithdrawal)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn lập lệnh này không ?".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
            
            let params: NSDictionary = [
                "user_id":user_id,
                "amount": amount
            ]
            let url_send_withdrawal_now = API_URL + "/api_task/withdrawals.send_withdrawal_now"
            //self.Webservice_PostLapLenhRutTien(url: url_send_withdrawal_now, params:params)
            
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
        
        
        
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
            
            
            let headerAttributeModel:HeaderAttributeModel=HeaderAttributeModel(title: content, price: 0.0, note: "")
            self.list_header_attribute.append(headerAttributeModel)
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
    @IBAction func UIButtonTouchUpInsideAddOtherAttributeProduct(_ sender: UIButton) {
        
        let otherAttributeEditVC = self.storyboard?.instantiateViewController(identifier: "OtherAttributeEditVC") as! OtherAttributeEditVC
                otherAttributeEditVC.delegate = self
               otherAttributeEditVC.otherAttributeHeadIndex = sender.tag
               //otherAttributeEditVC.otherAttributeHead=self.headerAttributeTitleProduct[sender.tag]
               self.present(otherAttributeEditVC, animated: true, completion: nil)
        
        
        /*
        
        
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
            self.orderheaderAttributeTitleProduct.append([
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "stt"),
                CellOrtherHeadAttribute(title: content,is_head: false,columnType: "content", columnName: "title"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "note"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "content", columnName: "attributes"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "button",columnName: "edit"),
                CellOrtherHeadAttribute(title: "",is_head: false,columnType: "button",columnName: "delete"),
                
                
            ]);
            self.UICollectionViewOtherHeadAttribute.delegate = self
            self.UICollectionViewOtherHeadAttribute.dataSource = self
            self.UICollectionViewOtherHeadAttribute.reloadData()
            
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
        */
        
        
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
    func Webservice_GetAffiliateInfo(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getLichSuRutTienResponseModel = try jsonDecoder.decode(GetAffiliateInfoModel.self, from: jsonResponse!)
                    self.userAffiliateInfoModel=getLichSuRutTienResponseModel.userAffiliateInfoModel
                    self.UILabelSoTienToiDa.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.userAffiliateInfoModel.total-self.userAffiliateInfoModel.total_processing),decimalCount: 0)
                    
                    
                    
                    
                } catch let error as NSError  {
                    print("error: \(error)")
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
                let imageColorModel:ImageColorModel=ImageColorModel(color_name: "", image: assets[i], color_value: UIColor.brown)
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
    func refreshData(AttributeHeadIndex: Int, CellAttributeList: [[CellAttribute]]) {
        var list_attribute:[String]=[String]()
        for i in 0..<CellAttributeList.count
           {
            list_attribute.append("\(CellAttributeList[i][1].title!)(\(CellAttributeList[i][2].title!))");
           }
        let joined2 = list_attribute.joined(separator: ", ")
        self.headerAttributeTitleProduct[AttributeHeadIndex][3].title=joined2
        self.headerAttributeTitleProduct[AttributeHeadIndex][3].list_attribute=CellAttributeList
        self.UICollectionViewHeaderAttributes.delegate = self
       self.UICollectionViewHeaderAttributes.dataSource = self
       self.UICollectionViewHeaderAttributes.reloadData()
    }
    
    
}

extension AddNewProductVC: OtherAttributeEditDelegate {
    func refreshData() {
        
    }
    
    
    
}
extension AddNewProductVC: ModalSelectColorRutDelegate {
    func refreshData(colorIndex:Int,color: UIColor) {
        if(colorIndex == -1){
            let no_image  = UIImage(named: "placeholder_image")!
            let imageColorModel:ImageColorModel=ImageColorModel(color_name: "", image:no_image, color_value: color)
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

