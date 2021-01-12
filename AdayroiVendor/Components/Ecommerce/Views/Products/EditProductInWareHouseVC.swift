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
    func refreshData(productInWarehouseIndex:Int,productInWarehouse:ProductInWarehouseModel)
}

class EditProductInWareHouseVC: UIViewController {
    
    @IBOutlet weak var UITextFieldTotalProduct: UITextField!
    @IBOutlet weak var UISwitchUnlimitTotal: UISwitch!
    var delegate: EditProductInWareHouseVCEditDelegate!
    var userAffiliateInfoModel:UserAffiliateInfoModel=UserAffiliateInfoModel()
    var customMask = TLCustomMask()
    var productInWarehouse:ProductInWarehouseModel = ProductInWarehouseModel()
    var productInWarehouseIndex:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UITextFieldTotalProduct.text=String(productInWarehouse.total_product)
        UISwitchUnlimitTotal.isOn=productInWarehouse.unlimit == 1 ? true : false
        if(productInWarehouse.unlimit == 1){
            UITextFieldTotalProduct.text=""
            UITextFieldTotalProduct.isEnabled=false
        }else{
            UITextFieldTotalProduct.isEnabled=true
        }
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
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập Số lượng sản phẩm có trong kho hàng này", preferredStyle: .alert)
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
            if((totalProduct as NSString).floatValue > 10000){
                
                UITextFieldTotalProduct.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Nếu bạn có nhiều sản phẩm xin chọn 'không giới hạn số lượng'", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            self.productInWarehouse.total_product=Int(UITextFieldTotalProduct.text!) ?? 0
            self.productInWarehouse.unlimit=0
        }else{
            self.productInWarehouse.unlimit=1
        }
        self.dismiss(animated: true) {
            self.delegate.refreshData(productInWarehouseIndex:self.productInWarehouseIndex,productInWarehouse: self.productInWarehouse)
           }

        
        
    }
    
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

extension EditProductInWareHouseVC {
   
    
    
}


