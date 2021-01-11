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



protocol QLKhoHangVCDelegate {
    func refreshData(AttributeHeadIndex:Int,CellKhoHangList:[[CellWareHouseHeadManager]])
}



class EditKhoHangCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditKhoHangCollectionViewCell"
}


class QlKhoHangVC: UIViewController {
    
    
    var attributeHeadIndex:Int=0
    var attributeHead:[CellHeaderAttribute]=[CellHeaderAttribute]()
    
    @IBOutlet weak var UILabelQLCacThuocTinh: UILabel!
    @IBOutlet weak var UICollectionViewListProductImage: UICollectionView!
    
    var wareHouseList = [[
        CellWareHouseHeadManager(title: "Stt", is_head: true,columnType: "", columnName: ""),
        CellWareHouseHeadManager(title: "Tên kho hàng", is_head: true,columnType: "", columnName: ""),
        CellWareHouseHeadManager(title: "Địa chỉ kho hàng", is_head: true,columnType: "", columnName: ""),
        CellWareHouseHeadManager(title: "Sửa", is_head: true,columnType: "", columnName: ""),
        CellWareHouseHeadManager(title: "Xóa", is_head: true,columnType: "",columnName: ""),
        
        
        ]]
    
    
    @IBOutlet weak var UICollectionViewWareHouses: UICollectionView!
    
    @IBOutlet weak var UIButtonAddWareHouse: UIButton!
    
    var Delegate: QLKhoHangVCDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        var nibCell = UINib(nibName:WarehouseManagerLabelCollectionViewCell.reuseID, bundle: nil)
       self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WarehouseManagerLabelCollectionViewCell.reuseID)
       
       nibCell = UINib(nibName:WareHouseManagerEditCollectionViewCell.reuseID, bundle: nil)
       self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WareHouseManagerEditCollectionViewCell.reuseID)
       
       nibCell = UINib(nibName:WareHouseManagerDeleteCollectionViewCell.reuseID, bundle: nil)
       self.UICollectionViewWareHouses.register(nibCell, forCellWithReuseIdentifier: WareHouseManagerDeleteCollectionViewCell.reuseID)
               
                                       
        
        /*
         let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
         print(" ")
         phoneFormatter.format("+123456789012") /
         */
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlGetCategories = API_URL + "/api/categories"
        
        
        cornerRadius(viewName: self.UIButtonAddWareHouse, radius: self.UIButtonAddWareHouse.frame.height / 2)
        
        
        //self.AttributeNameList[0][1].title = self.attributeHead[1].title!
        self.UICollectionViewWareHouses.delegate = self
        self.UICollectionViewWareHouses.dataSource = self
        //self.UILabelQLCacThuocTinh.text="Quản lý các thuộc tính:\(self.attributeHead[1].title!)";
        /*
        if(self.attributeHead[3].list_attribute.count>0){
            for i in 0..<self.attributeHead[3].list_attribute.count
            {
                //AttributeNameList.append(attributeHead[3].list_attribute[i]);
            }
            
            
        }
         */
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    var alertTextFieldTitle: UITextField!
    @objc func textFieldDidChangeTitle(){
        if let e = alertTextFieldTitle.text {
            let alertButton = alertController.actions[0]
            let title=e.trimmingCharacters(in: .whitespacesAndNewlines)
            let price=self.alertTextFieldPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            print("title:\(title), price:\(price)")
            alertButton.isEnabled = (title == "" || price == "") ? false : true
        }
    }
    var alertTextFieldPrice: UITextField!
    @objc func textFieldDidChangePrice(){
        
        if let e = alertTextFieldPrice.text {
            let alertButton = alertController.actions[0]
            let title = self.alertTextFieldTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let price=e.trimmingCharacters(in: .whitespacesAndNewlines)
            print("title:\(title), price:\(price)")
            alertButton.isEnabled = (title=="" || price=="") ? false : true
        }
    }
    var alertController:UIAlertController=UIAlertController()
    
    @IBAction func UIButtonEditHeadAttribute(_ sender: UIButton) {
        
       let editWareHouseVC = self.storyboard?.instantiateViewController(identifier: "EditWareHouseVC") as! EditWareHouseVC
        editWareHouseVC.delegate = self
        //editWareHouseVC.attributeHeadIndex = sender.tag
        //editWareHouseVC.attributeHead=self.headerAttributeTitleProduct[sender.tag]
        self.present(editWareHouseVC, animated: true, completion: nil)
        
    }
    
    @IBAction func UIButtonDeleteHeadAtrribute(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            self.wareHouseList.remove(at: sender.tag)
            self.UICollectionViewWareHouses.delegate = self
            self.UICollectionViewWareHouses.dataSource = self
            self.UICollectionViewWareHouses.reloadData()
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
    }
    
    
    
    @IBAction func UIButtonTouchUpInsideAddAttributeAndPrice(_ sender: UIButton) {
        let editWareHouseVC = self.storyboard?.instantiateViewController(identifier: "EditWareHouseVC") as! EditWareHouseVC
        editWareHouseVC.delegate = self
        //editWareHouseVC.attributeHeadIndex = sender.tag
        //editWareHouseVC.attributeHead=self.headerAttributeTitleProduct[sender.tag]
        self.present(editWareHouseVC, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func UIButtonSave(_ sender: UIButton) {
        self.wareHouseList.remove(at: 0)
        self.Delegate.refreshData(AttributeHeadIndex:self.attributeHeadIndex,CellKhoHangList: self.wareHouseList)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}



//MARK: WithdrawalList
extension QlKhoHangVC {
    
    
    
    
    
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
                        
                        
                        
                        
                        
                        
                    }
                    
                } catch let error as NSError  {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Có lỗi phát sinh")
                    
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
    }
    
    
}


extension QlKhoHangVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView==self.UICollectionViewListProductImage){
            return 1
        }else if(collectionView==self.UICollectionViewWareHouses){
            print("self.headerAttributeTitleProduct.count:\(self.wareHouseList.count)")
            return self.wareHouseList.count
        }
        else{
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wareHouseList[0].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CellKhoHang:CellWareHouseHeadManager=self.wareHouseList[indexPath.section][indexPath.row]
        let cell  = CellKhoHang.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
        return cell
        
        
        
        
        
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

extension QlKhoHangVC: EditWareHouseVCEditDelegate {
    func refreshData(warehouseModel: WarehouseModel) {
        self.wareHouseList.append([
        CellWareHouseHeadManager(title: "", is_head: false,columnType: "content", columnName: "stt"),
        CellWareHouseHeadManager(title: warehouseModel.warehouse_name, is_head: false,columnType: "content", columnName: ""),
        CellWareHouseHeadManager(title: warehouseModel.warehouse_address, is_head: false,columnType: "content", columnName: ""),
        CellWareHouseHeadManager(title: "Sửa", is_head: false,columnType: "button", columnName: "edit"),
        CellWareHouseHeadManager(title: "Xóa", is_head: false,columnType: "button",columnName: "delete"),
        ])
        self.UICollectionViewWareHouses.delegate = self
        self.UICollectionViewWareHouses.dataSource = self
        self.UICollectionViewWareHouses.reloadData()
    }
}
