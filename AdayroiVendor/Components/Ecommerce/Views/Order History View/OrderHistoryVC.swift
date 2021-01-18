//
//  OrderHistoryVC.swift
//  AdayroiVendor
//
//  Created by Mitesh's MAC on 07/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON


class OrderHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lbl_OrderNoLabel: UILabel!
    @IBOutlet weak var lbl_QtyLabel: UILabel!
    @IBOutlet weak var lbl_orderStatusLabel: UILabel!
    
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_PaymentType: UILabel!
    @IBOutlet weak var lbl_OrderNumber: UILabel!
    @IBOutlet weak var lbl_itemPrice: UILabel!
    @IBOutlet weak var UILabelOrderStatus: UILabel!
    @IBOutlet weak var lbl_itemQty: UILabel!
}


class OrderHistoryVC: UIViewController {
    @IBOutlet weak var Tableview_OrderHistory: UITableView!
    @IBOutlet weak var lbl_titleLabel: UILabel!
    var refreshControl = UIRefreshControl()
    var list_my_order:[OrderModel] = [OrderModel]()
    var selected = String()
     var orderHistoryDetailsDelegate: OrderHistoryDetailsDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selected = ""
        self.Tableview_OrderHistory.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        self.lbl_titleLabel.text = "Order History".localiz();
    }
    @objc private func refreshData(_ sender: Any) {
        self.refreshControl.endRefreshing()
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendororders/my_list_order/limit/30/start/0?user_id=\(user_id)"
        self.Webservice_GetHistory(url: urlString, params:[:])
    }
    override func viewWillAppear(_ animated: Bool) {
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendororders/my_list_order/limit/30/start/0?user_id=\(user_id)"
        self.Webservice_GetHistory(url: urlString, params:[:])
    }
    @IBAction func btnTap_Menu(_ sender: UIButton) {
        if UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "en" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "N/A"
        {
            self.slideMenuController()?.openLeft()
        }
        else {
            self.slideMenuController()?.openRight()
        }
    }
}
extension OrderHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.Tableview_OrderHistory.bounds.size.width, height: self.Tableview_OrderHistory.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        //messageLabel.font = UIFont(name: "POPPINS-REGULAR", size: 15)!
        messageLabel.sizeToFit()
        self.Tableview_OrderHistory.backgroundView = messageLabel;
        if self.list_my_order.count == 0 {
            messageLabel.text = "NO ORDER HISTORY"
        }
        else {
            messageLabel.text = ""
        }
        return self.list_my_order.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        _ = self.list_my_order[indexPath.row]
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.Tableview_OrderHistory.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as! OrderHistoryCell
        let order = self.list_my_order[indexPath.row]
        cell.lbl_QtyLabel.text = "Số lượng sản phẩm :".localiz()
        cell.lbl_OrderNoLabel.text = "Số đơn hàn :".localiz()
        cell.lbl_orderStatusLabel.text = "Trạng thái đơn hàng :".localiz()
        cell.lbl_itemQty.text = String(order.total_amount_product)
        cell.lbl_Date.text = order.created_date
        //let setdate = DateFormater.getBirthDateStringFromDateString(givenDate:data["created_date"].stringValue)
        //cell.lbl_Date.text = setdate
        //_ = data["order_status_id"].stringValue
        
        cell.lbl_OrderNumber.text = order.order_number
        cell.lbl_itemPrice.text = LibraryUtilitiesUtility.format_currency(amount: UInt64(order.total_cost_final), decimalCount: 0)
        cell.lbl_PaymentType.text =  order.payment_method_name
        cell.UILabelOrderStatus.text=order.orderStatus?.name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = self.list_my_order[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(identifier: "OrderHistoryDetailsVC") as! OrderHistoryDetailsVC
        vc.OrderId = order.order_id
        vc.orderHistoryDetailsDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc,animated: true,completion: nil)
    }
    
}
//MARK: Webservices
extension OrderHistoryVC {
    func Webservice_GetHistory(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponeGetListMyOrders = try jsonDecoder.decode(ApiResponeGetListMyOrders.self, from: jsonResponse!)
                    
                    self.list_my_order=apiResponeGetListMyOrders.list_my_orders
                    print("self.list_my_order \(self.list_my_order)")
                    self.Tableview_OrderHistory.delegate = self
                    self.Tableview_OrderHistory.dataSource = self
                    self.Tableview_OrderHistory.reloadData()
                    
                } catch let error as NSError  {
                    print("error: \(error)")
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
        
        
        
    }
    
    /*
    func Webservice_GetHistory(url:String, params:NSDictionary) -> Void {
        
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: "", messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let responseData = jsonResponse!["list_order"].arrayValue
                    self.OrderHistoryData = responseData
                    self.selected = ""
                    self.Tableview_OrderHistory.delegate = self
                    self.Tableview_OrderHistory.dataSource = self
                    self.Tableview_OrderHistory.reloadData()
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
 */
}
extension OrderHistoryVC: OrderHistoryDetailsDelegate {
    
    func refreshData() {
        
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendororders/my_list_order/limit/30/start/0?user_id=\(user_id)"
        self.Webservice_GetHistory(url: urlString, params:[:])
    }
}
