//
//  OrderHistoryDetailsVC.swift
//  AdayroiVendor
//
//  Created by Mitesh's MAC on 09/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import iOSDropDown
import TagListView
class historyOrderProductCell: UICollectionViewCell {
    
    @IBOutlet weak var UILabelColorValue: UILabel!
    @IBOutlet weak var UIImageViewColor: UIImageView!
    @IBOutlet weak var UIImageViewProduct: UIImageView!
    @IBOutlet weak var UILabelProductName: UILabel!
    @IBOutlet weak var UILabelPrice: UILabel!
    @IBOutlet weak var UILabelquality: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var UILabelTotal: UILabel!
    /*
     @IBOutlet weak var UILabelPrice: UILabel!
     @IBOutlet weak var UILabelquality: UILabel!
     @IBOutlet weak var UILabelTotal: UILabel!
     @IBOutlet weak var UILabelProductName: UILabel!
     
     @IBOutlet weak var UICollectionViewAttributeNameValue: UICollectionView!
     */
    
}

class OrderHistoryDetailsVC: UIViewController {
    
    @IBOutlet weak var btn_cancelHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var lbl_titleLabel: UILabel!
    var OrderNumber = String()
    var status = String()
    var OrderId:String=""
    var OrderDetailsData = [JSON]()
    var list_product:[OrderProductModel]=[OrderProductModel]()
    var taxStr = "Tax".localiz()
    var orderModel:OrderModel?
    @IBOutlet weak var UILabelOrderNumber: UILabel!
    @IBOutlet weak var UILabelCopyOrderNUmber: UILabel!
    @IBOutlet weak var UILabelOrderStatus: UILabel!
    @IBOutlet weak var UILabelTotalCountProduct: UILabel!
    @IBOutlet weak var UILabelTotalCostBeforTax: UILabel!
    @IBOutlet weak var UILabelDiscountAmount: UILabel!
    @IBOutlet weak var UILabelTotalCostAfterDiscountAndBeforTax: UILabel!
    @IBOutlet weak var UILabelTax: UILabel!
    @IBOutlet weak var UILabelShippingAmout: UILabel!
    @IBOutlet weak var UILabelTaxPercent: UILabel!
    @IBOutlet weak var UILabelTotalCoustAfterTax: UILabel!
    @IBOutlet weak var UILabelShippingPhoneNumber: UILabel!
    @IBOutlet weak var UILabelShippingEmail: UILabel!
    @IBOutlet weak var UILabelShippingAddress1: UILabel!
    @IBOutlet weak var UILabelShippingAddress2: UILabel!
    @IBOutlet weak var UILabelBillingPhoneNumber: UILabel!
    @IBOutlet weak var UILabelBillingEmail: UILabel!
    @IBOutlet weak var UILabelBillingAddress1: UILabel!
    @IBOutlet weak var UILabelBillingAddress2: UILabel!
    @IBOutlet weak var UIImageViewColorImage: UIImageView!
    @IBOutlet weak var UIImageViewProductImage: UIImageView!
    @IBOutlet weak var UICollectionViewOrderProducts: UICollectionView!
    @IBOutlet weak var UILabelTaxtPercent: UILabel!
    @IBOutlet weak var UILabelShippingFullName: UILabel!
    @IBOutlet weak var UILabelBillingFullName: UILabel!
    @IBOutlet weak var UIButtonShippingPhoneNumber: UIButton!
    @IBOutlet weak var UIButtonBillingPhoneNumber: UIButton!
    @IBOutlet weak var DropDownOrderStatus: DropDown!
    var orderStatusOfOrder:OrderStatusModel?
    var list_order_status:[OrderStatusModel]=[OrderStatusModel]()
    var driver_mobile = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "historyOrderProductCell", bundle: nil)
        self.UICollectionViewOrderProducts.register(nib, forCellWithReuseIdentifier: "cell")
        let urlString = API_URL + "/api/vendororders/\(self.OrderId)"
        self.Webservice_getOrderInfo(url: urlString, params:[:])
        
        
    }
    @IBAction func btnTap_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnTap_Cancel(_ sender: UIButton) {
        let urlString = API_URL + "ordercancel"
        let params: NSDictionary = ["order_id":self.OrderId]
        self.Webservice_CancelOrder(url: urlString, params:params)
    }
    
    @IBAction func btnTapCallReceiver(_ sender: UIButton) {
        callNumber(phoneNumber: (self.orderModel?.shipping_phone)! ?? "09123445")
    }
    @IBAction func btnTapCallBilling(_ sender: UIButton) {
           callNumber(phoneNumber: (self.orderModel?.billing_phone)! ?? "09123445")
       }
    func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
extension OrderHistoryDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView==self.UICollectionViewOrderProducts){
            return self.list_product.count
        }else{
            return self.list_product[collectionView.tag].list_attribute_value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.UICollectionViewOrderProducts.dequeueReusableCell(withReuseIdentifier: "historyOrderProductCell", for: indexPath) as! historyOrderProductCell
        let element=self.list_product[indexPath.row]
        cell.UILabelPrice.text=String(element.unit_price)
        cell.UILabelProductName.text=element.product_name
        cell.UILabelTotal.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(element.total), decimalCount: 0)
        
        cell.UILabelColorValue.text=element.color_value
        cell.UIImageViewColor.sd_setImage(with: URL(string: element.color_image), placeholderImage: UIImage(named: "placeholder_image"))
        cell.UIImageViewProduct.sd_setImage(with: URL(string: element.imageUrl), placeholderImage: UIImage(named: "placeholder_image"))
        
        cell.tagListView.textFont = UIFont.systemFont(ofSize: 14)
        cell.tagListView.alignment = .left // possible values are [.leading, .trailing, .left, .center, .right]
        for attribute in element.list_attribute_value{
            cell.tagListView.addTag("\(attribute.name):\(attribute.value)")
        }
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) / 1, height: 220.0)
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}




//MARK: Webservices
extension OrderHistoryDetailsVC {
    func Webservice_getOrderInfo(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getOrderResponseModel = try jsonDecoder.decode(GetOrderResponseModel.self, from: jsonResponse!)
                    self.orderModel=getOrderResponseModel.order
                    self.list_product=self.orderModel!.list_product;
                    self.UILabelOrderNumber.text=self.orderModel!.order_number
                    self.UILabelTotalCountProduct.text=String(self.orderModel!.total_amount_product)
                    self.UILabelBillingAddress1.text=self.orderModel!.billing_address_1
                    self.UILabelBillingAddress2.text=self.orderModel!.billing_address_2
                    self.UILabelBillingEmail.text=self.orderModel!.billing_email
                    self.UILabelBillingFullName.text=self.orderModel!.billing_full_name
                    self.UIButtonBillingPhoneNumber.setTitle(self.orderModel!.billing_phone, for: .normal)
                    self.UILabelShippingAddress2.text=self.orderModel!.shipping_address_2
                    self.UILabelShippingAddress1.text=self.orderModel!.shipping_address_1
                    self.UILabelShippingEmail.text=self.orderModel!.shipping_email
                    self.UILabelShippingFullName.text=self.orderModel!.shipping_full_name
                    self.UIButtonShippingPhoneNumber.setTitle(self.orderModel!.shipping_phone, for: .normal)
                    self.UILabelTotalCoustAfterTax.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.toal_cost_after_discount_and_befor_tax), decimalCount: 0)
                    self.UILabelShippingAmout.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.shipping_amount), decimalCount: 0)
                    self.UILabelTotalCostAfterDiscountAndBeforTax.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.toal_cost_after_discount_and_befor_tax), decimalCount: 0)
                    self.UILabelTotalCostBeforTax.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.total_cost_befor_tax), decimalCount: 0)
                    self.UILabelDiscountAmount.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.discount_amount), decimalCount: 0)
                    self.UILabelTotalCoustAfterTax.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.total_cost_final), decimalCount: 0)
                    self.UILabelTax.text=LibraryUtilitiesUtility.format_currency(amount: UInt64(self.orderModel!.tax_amount), decimalCount: 0)
                    //self.UI.text=String(orderModel.tax_amount)
                    self.UILabelTaxtPercent.text="Thuế (\(self.orderModel!.tax_percent)%)"
                    self.UICollectionViewOrderProducts.delegate=self
                    self.UICollectionViewOrderProducts.dataSource = self
                    self.UICollectionViewOrderProducts.reloadData()
                    self.orderStatusOfOrder = (self.orderModel?.orderStatus)!
                    let urlStringGettOrderStatus = API_URL + "/api/orderstatus/list"
                    self.Webservice_getOrderStatus(url: urlStringGettOrderStatus, params:[:])
                    
                    
                    print("orderModel:\(self.orderModel!)")
                } catch let error as NSError  {
                    print("error: \(error)")
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
        
        
        
    }
    func Webservice_getOrderStatus(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiResponeOrderStatusModel = try jsonDecoder.decode(GetApiResponeOrderStatusModel.self, from: jsonResponse!)
                    if(getApiResponeOrderStatusModel.result=="success"){
                        
                        self.list_order_status=getApiResponeOrderStatusModel.list_order_status
                        
                        var selectedIndex:Int = -1
                        for index in 0...self.list_order_status.count-1 {
                            let currentItem=self.list_order_status[index]
                            self.DropDownOrderStatus.optionArray.append(currentItem.name)
                            self.DropDownOrderStatus.optionIds?.insert(index, at: index)
                            
                            if(self.orderStatusOfOrder!._id != "" && self.orderStatusOfOrder!._id ==  currentItem._id){
                                selectedIndex=index
                            }
                            
                        }
                        if(selectedIndex != -1){
                            self.DropDownOrderStatus.selectedIndex=selectedIndex
                            self.DropDownOrderStatus.text=self.orderStatusOfOrder!.name
                        }
                        
                        
                        
                    }
                    
                } catch let error as NSError  {
                    print("error: \(error)")
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    
    
    func Webservice_CancelOrder(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: "", messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["status"].stringValue
                if responseCode == "1" {
                    //                    let responseData = jsonResponse!["data"].arrayValue
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
}
