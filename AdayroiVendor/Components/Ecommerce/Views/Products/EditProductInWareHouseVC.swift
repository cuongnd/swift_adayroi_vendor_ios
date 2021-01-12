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

protocol EditProductInWareHouseVCEditDelegate {
    func refreshData(warehouse_index:Int,warehouseModel:WarehouseModel)
}

class EditProductInWareHouseVC: UIViewController {
    
    @IBOutlet weak var UITextFieldTotalProduct: UITextField!
    @IBOutlet weak var UISwitchUnlimitTotal: UISwitch!
    var delegate: EditProductInWareHouseVCEditDelegate!
    var userAffiliateInfoModel:UserAffiliateInfoModel=UserAffiliateInfoModel()
    var customMask = TLCustomMask()
    var warehouse:WarehouseModel = WarehouseModel()
    var warehouse_index:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UITextFieldTotalProduct.text=warehouse.warehouse_name
        /*
         let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
         print(" ")
         phoneFormatter.format("+123456789012") /
         */
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    @IBAction func UISwitchUnlimitChangeStatus(_ sender: UISwitch) {
        if(sender.isOn){
            UITextFieldTotalProduct.text=""
            UITextFieldTotalProduct.isEnabled=false
        }else{
            UITextFieldTotalProduct.isEnabled=true
        }
    }
   
    
    @IBAction func btnTapSave(_ sender: UIButton) {
        
       
        
        var totalProduct=String(self.UITextFieldTotalProduct.text!)
        totalProduct = String(totalProduct.filter { !" \n\t\r".contains($0) })
        if(!UISwitchUnlimitTotal.isOn){
            if(totalProduct==""){
                UITextFieldTotalProduct.text="";
                UITextFieldTotalProduct.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên kho hàng", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if(!totalProduct.isNumber){
                UITextFieldTotalProduct.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các số không bao gồm chữ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if((totalProduct as NSString).floatValue < 10000){
                
                UITextFieldTotalProduct.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Nếu bạn có nhiều sản phẩm xin chọn 'không giới hạn số lượng'", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
        }else{
            
        }
        
        
        
        
    }
    
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

extension EditProductInWareHouseVC {
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


