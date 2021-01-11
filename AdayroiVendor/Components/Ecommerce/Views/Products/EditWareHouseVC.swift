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

protocol EditWareHouseVCEditDelegate {
    func refreshData(warehouse_index:Int,warehouseModel:WarehouseModel)
}

class EditWareHouseVC: UIViewController {
    
    @IBOutlet weak var btn_ok: UIButton!
    @IBOutlet weak var UITextViewWareHouseAddress: UITextView!
    @IBOutlet weak var UITextFieldWareHouseName: UITextField!
    @IBOutlet weak var UITextFieldWareHousePhoneNumber: UITextField!
    var delegate: EditWareHouseVCEditDelegate!
    var userAffiliateInfoModel:UserAffiliateInfoModel=UserAffiliateInfoModel()
    var customMask = TLCustomMask()
    var warehouse:WarehouseModel = WarehouseModel()
    var warehouse_index:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UITextFieldWareHouseName.text=warehouse.warehouse_name
        self.UITextViewWareHouseAddress.text=warehouse.warehouse_address
        self.UITextFieldWareHousePhoneNumber.text=warehouse.warehouse_phonenumber
        /*
         let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
         print(" ")
         phoneFormatter.format("+123456789012") /
         */
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func btnTapSave(_ sender: UIButton) {
        
        var wareHouseName=String(self.UITextFieldWareHouseName.text!)
        var wareHouseAddress=String(self.UITextViewWareHouseAddress.text!)
        var wareHousePhoneNumber=String(self.UITextFieldWareHousePhoneNumber.text!)
        
        wareHouseName = String(wareHouseName.filter { !" \n\t\r".contains($0) })
        wareHouseAddress = String(wareHouseAddress.filter { !" \n\t\r".contains($0) })
        wareHousePhoneNumber = String(wareHousePhoneNumber.filter { !" \n\t\r".contains($0) })
        
        if(wareHouseName==""){
            UITextFieldWareHouseName.text="";
            UITextFieldWareHouseName.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên kho hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if(wareHouseAddress==""){
            UITextViewWareHouseAddress.text="";
            UITextViewWareHouseAddress.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập địa chỉ kho  hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if(wareHousePhoneNumber==""){
            UITextFieldWareHousePhoneNumber.text="";
            UITextFieldWareHousePhoneNumber.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại kho hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId)
        if(warehouse._id != ""){
            let params: NSDictionary = [
                "_id": warehouse._id,
                "warehouse_name": wareHouseName,
                "warehouse_address": wareHouseAddress,
                "warehouse_phonenumber": wareHousePhoneNumber
            ]
            
            let urlStringPostUpdateWarehouse = API_URL + "/api_task/warehouse.update_warehouse?user_id=\(user_id)"
            self.Webservice_getUpdateWareHouse(url: urlStringPostUpdateWarehouse, params: params)
        }else{
            let params: NSDictionary = [
                "_id": warehouse._id,
                "warehouse_name": wareHouseName,
                "warehouse_address": wareHouseAddress,
                "warehouse_phonenumber": wareHousePhoneNumber
            ]
            
            let urlStringPostUpdateWarehouse = API_URL + "/api_task/warehouse.add_warehouse?user_id=\(user_id)"
            self.Webservice_getUpdateWareHouse(url: urlStringPostUpdateWarehouse, params: params)
            
        }
        
        
        
        
    }
    
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

extension EditWareHouseVC {
    func Webservice_getUpdateWareHouse(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponseUpdateWarehousesModel = try jsonDecoder.decode(GetApiResponseUpdateWarehousesModel.self, from: jsonResponse!)
                    print("getApiResponseUpdateWarehousesModel \(getApiResponseUpdateWarehousesModel)")
                    if(getApiResponseUpdateWarehousesModel.result=="success"){
                        let warehouseModel=getApiResponseUpdateWarehousesModel.warehouse
                        self.dismiss(animated: true) {
                            self.delegate.refreshData(warehouse_index:self.warehouse_index,warehouseModel: warehouseModel)
                        }
                        
                        
                        
                        
                        
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    
}


