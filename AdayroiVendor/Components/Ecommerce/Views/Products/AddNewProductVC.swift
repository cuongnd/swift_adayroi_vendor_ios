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
    let color_name: String
    let image: UIImage
    var color_value: UIColor
    init(color_name:String,image:UIImage,color_value:UIColor) {
        self.color_name=color_name
        self.image=image
        self.color_value=color_value
    }
}



class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIImageViewImageUpload: UIImageView!
    @IBOutlet weak var UIButtonDeleteImage: UIButton!
    @IBOutlet weak var UILabelDescription: UILabel!
    static let reuseID = "ImageCollectionViewCell"
}
class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIImageViewImageUpload: UIImageView!
    @IBOutlet weak var UIButtonDeleteImage: UIButton!
    @IBOutlet weak var UILabelDescription: UILabel!
    @IBOutlet weak var UIButtonColor: UIButton!
    static let reuseID = "ColorCollectionViewCell"
}

class TextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UILabelHeaderName: UILabel!
    static let reuseID = "TextCollectionViewCell"
}

class AddNewProductVC: UIViewController {
    
    @IBOutlet weak var btn_ok: UIButton!
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
    var list_image:[UIImage]=[UIImage]()
    var list_image_color:[ImageColorModel]=[ImageColorModel]()
    
    @IBOutlet weak var UICollectionViewListImage: UICollectionView!
    let imagePicker = UIImagePickerController()
    let multiImagePicker = OpalImagePickerController()
    let multiImageColorPicker = OpalImagePickerController()
    let headerTitlesImage = [
        DataRowModel(type: .Text, text:DataTableValueType.string("STT"),key_column: "stt",column_width: 50,column_height: 50),
        DataRowModel(type:.Text, text:DataTableValueType.string("Image"),key_column: "image",column_width: 100,column_height: 50),
        DataRowModel(type: .Text, text:DataTableValueType.string("Description"),key_column: "description",column_width: 150,column_height: 50),
        DataRowModel(type: .Text, text:DataTableValueType.string("Action"),key_column: "delete",column_width: 100,column_height: 50)
        
    ]
    
    @IBOutlet weak var UIButtonColor: UIButton!
    @IBOutlet weak var UICollectionViewColorProducts: UICollectionView!
    var list_image_source:[[DataRowModel]]=[[DataRowModel]]()
    @IBOutlet weak var UIButtonPickupColor: UIButton!

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
        
        
        multiImagePicker.imagePickerDelegate = self
        multiImageColorPicker.imagePickerDelegate = self
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
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
                          self.list_image.remove(at: imageIndex)
                          self.UICollectionViewListImage.delegate = self
                          self.UICollectionViewListImage.dataSource = self
                          self.UICollectionViewListImage.reloadData()
                   
               }
               let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
               alertVC.addAction(yesAction)
               alertVC.addAction(noAction)
               self.present(alertVC,animated: true,completion: nil)
               
        
       
        
    }
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
            self.list_image.append(pickedImage)
            //self.img_Profile.image = pickedImage
        }
        self.UICollectionViewListImage.delegate = self
        self.UICollectionViewListImage.dataSource = self
        self.UICollectionViewListImage.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddNewProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==self.UICollectionViewListImage){
            return self.list_image.count
        }else{
            return self.list_image_color.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==self.UICollectionViewListImage){
            let uIimage:UIImage=self.list_image[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseID, for: indexPath) as? ImageCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.UIImageViewImageUpload.image=uIimage
            cell.UIButtonDeleteImage.tag=indexPath.row
            cornerRadius(viewName: cell.UIButtonDeleteImage, radius: cell.UIButtonDeleteImage.frame.height / 2)
            //cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white
            return cell
        }else{
            let uIimage:UIImage=self.list_image_color[indexPath.row].image
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseID, for: indexPath) as? ColorCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.UIImageViewImageUpload.image=uIimage
            cell.UIButtonDeleteImage.tag=indexPath.row
            cell.UIButtonColor.tag=indexPath.row
            cell.UIButtonColor.tintColor=self.list_image_color[indexPath.row].color_value
            cornerRadius(viewName: cell.UIButtonDeleteImage, radius: cell.UIButtonDeleteImage.frame.height / 2)
            cornerRadius(viewName: cell.UIButtonColor, radius: cell.UIButtonColor.frame.height / 2)
            
            //cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white
            return cell
        }
        
        
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView==self.UICollectionViewListImage){
            return CGSize(width:(UIScreen.main.bounds.width-26)/2, height: 250)
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
                    self.list_image.append(assets[i])
            }

            
            self.UICollectionViewListImage.delegate = self
            self.UICollectionViewListImage.dataSource = self
            self.UICollectionViewListImage.reloadData()
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


