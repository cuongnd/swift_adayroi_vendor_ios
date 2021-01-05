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
protocol AddNewProductDelegate {
    func refreshData()
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
    
    @IBAction func UIButtonClickAddImage(_ sender: UIButton) {
        //self.imagePicker.delegate = self
        let alert = UIAlertController(title: "", message: "Select image".localiz(), preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localiz(), style: .default) { (action) in
            //self.imagePicker.sourceType = .photoLibrary
            //self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera".localiz(), style: .default) { (action) in
            //self.imagePicker.sourceType = .camera
            //self.present(self.imagePicker, animated: true, completion: nil)
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
