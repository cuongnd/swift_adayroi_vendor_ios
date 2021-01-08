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



protocol ModalAttributeHeadIndexDelegate {
    func refreshData(AttributeHeadIndex:Int,CellAttributeList:[[CellAttribute]])
}

struct CellAttribute {
    var title:String!
    var is_head:Bool!
    var columnType:String!
    var columnName:String!
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



class EditAttributeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIButtonEdit: UIButton!
    static let reuseID = "EditAttributesCollectionViewCell"
}


class QlCacThuocTinhVC: UIViewController {
    

    var attributeHeadIndex:Int=0
    var attributeHead:[CellHeaderAttribute]=[CellHeaderAttribute]()
    
    @IBOutlet weak var UILabelQLCacThuocTinh: UILabel!
    @IBOutlet weak var UICollectionViewListProductImage: UICollectionView!
   
    var AttributeNameList = [[
        CellAttribute(title: "Stt", is_head: true,columnType: "", columnName: ""),
        CellAttribute(title: "Title", is_head: true,columnType: "", columnName: ""),
        CellAttribute(title: "Price", is_head: true,columnType: "", columnName: ""),
        CellAttribute(title: "Sửa", is_head: true,columnType: "", columnName: ""),
        CellAttribute(title: "Xóa", is_head: true,columnType: "",columnName: ""),
        
        
        ]]
    
    
    @IBOutlet weak var UICollectionViewAttributes: UICollectionView!
    
    @IBOutlet weak var UIButtonAddHeaderAttribute: UIButton!
    
      var modalAttributeHeadIndexDelegate: ModalAttributeHeadIndexDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
         print(" ")
         phoneFormatter.format("+123456789012") /
         */
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlGetCategories = API_URL + "/api/categories"
        
        
        cornerRadius(viewName: self.UIButtonAddHeaderAttribute, radius: self.UIButtonAddHeaderAttribute.frame.height / 2)
        
        
        self.AttributeNameList[0][1].title = self.attributeHead[1].title!
        self.UICollectionViewAttributes.delegate = self
        self.UICollectionViewAttributes.dataSource = self
        self.UILabelQLCacThuocTinh.text="Quản lý các thuộc tính:\(self.attributeHead[1].title!)";
        if(self.attributeHead[3].list_attribute.count>0){
            for i in 0..<self.attributeHead[3].list_attribute.count
            {
             AttributeNameList.append(attributeHead[3].list_attribute[i]);
            }
            
            
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    var alertTextFieldTitle: UITextField!
    @objc func textFieldDidChangeTitle(){

        if let e = alertTextFieldTitle.text {
            let alertButton = alertController.actions[0]
            alertButton.isEnabled = e.trimmingCharacters(in: .whitespacesAndNewlines)=="" ? false : true
        }
    }
    @objc var alertTextFieldPrice: UITextField!
       @objc func textFieldDidChangePrice(){

           if let e = alertTextFieldTitle.text {
               let alertButton = alertController.actions[0]
               alertButton.isEnabled = e.trimmingCharacters(in: .whitespacesAndNewlines)=="" ? false : true
           }
       }
    var alertController:UIAlertController=UIAlertController()
    
    @IBAction func UIButtonEditHeadAttribute(_ sender: UIButton) {
        
        alertController = UIAlertController(title: "Tiêu đề thuộc tính", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
             self.alertTextFieldTitle = textField
            textField.placeholder = "Thuộc tính"
            textField.tag=sender.tag
            textField.text=self.AttributeNameList[sender.tag][1].title
            //textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(self.textFieldDidChangeTitle), for: UIControl.Event.editingChanged)
        }
        alertController.addTextField { textField in
            self.alertTextFieldPrice = textField
            textField.placeholder = "Giá"
            textField.tag=sender.tag
            textField.text=String(self.AttributeNameList[sender.tag][2].title)
            //textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(setter: self.alertTextFieldPrice), for: UIControl.Event.editingChanged)
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            let alertController = alertController
            let textFieldTitle = alertController?.textFields?.first
            let textFieldPrice = alertController?.textFields?.last
            
            let contentTitle=String(describing: textFieldTitle!.text!)
            let contentPrice=String(describing: textFieldPrice!.text!)
            if(contentTitle == "" || contentPrice == ""){
                return
            }
            self.AttributeNameList[textFieldTitle!.tag][1].title=contentTitle;
            self.AttributeNameList[textFieldPrice!.tag][2].title=contentPrice;
            self.UICollectionViewAttributes.delegate = self
            self.UICollectionViewAttributes.dataSource = self
            self.UICollectionViewAttributes.reloadData()
            //compare the current password and do action here
        }
        confirmAction.isEnabled = false
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func UIButtonDeleteHeadAtrribute(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: Bundle.main.displayName!, message: "Bạn có chắc chắn muốn xóa không ?".localiz(), preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes".localiz(), style: .default) { (action) in
            
            self.AttributeNameList.remove(at: sender.tag)
            self.UICollectionViewAttributes.delegate = self
            self.UICollectionViewAttributes.dataSource = self
            self.UICollectionViewAttributes.reloadData()
            
        }
        let noAction = UIAlertAction(title: "No".localiz(), style: .destructive)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC,animated: true,completion: nil)
        
        
    }
   

   
    @IBAction func UIButtonTouchUpInsideAddAttributeAndPrice(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Thêm thuộc tính và giá", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Thuộc tính"
            //textField.isSecureTextEntry = true
        }
        alertController.addTextField { textField in
                   textField.placeholder = "Giá"
                   //textField.isSecureTextEntry = true
               }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            let textFieldTitle = alertController?.textFields?.first
            let textFieldPrice = alertController?.textFields?.last
            let contentTitle=String(describing: textFieldTitle!.text!)
            let contentPrice=String(describing: textFieldPrice!.text!)
            self.AttributeNameList.append([
                CellAttribute(title: "", is_head: false,columnType: "content", columnName: "stt"),
                CellAttribute(title: contentTitle, is_head: false,columnType: "content", columnName: "title"),
                CellAttribute(title: contentPrice, is_head: false,columnType: "content", columnName: "note"),
                CellAttribute(title: "", is_head: false,columnType: "button",columnName: "edit"),
                CellAttribute(title: "", is_head: false,columnType: "button",columnName: "delete"),
                
                
            ]);
            self.UICollectionViewAttributes.delegate = self
            self.UICollectionViewAttributes.dataSource = self
            self.UICollectionViewAttributes.reloadData()
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func UIButtonCancel(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func UIButtonSave(_ sender: UIButton) {
        self.AttributeNameList.remove(at: 0)
        self.modalAttributeHeadIndexDelegate.refreshData(AttributeHeadIndex:self.attributeHeadIndex,CellAttributeList: self.AttributeNameList)
               dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}



//MARK: WithdrawalList
extension QlCacThuocTinhVC {
    
    
    
   
    
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


extension QlCacThuocTinhVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView==self.UICollectionViewListProductImage){
            return 1
        }else if(collectionView==self.UICollectionViewAttributes){
            print("self.headerAttributeTitleProduct.count:\(self.AttributeNameList.count)")
            return self.AttributeNameList.count
        }
        else{
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.AttributeNameList[0].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cellAttribute:CellAttribute=self.AttributeNameList[indexPath.section][indexPath.row]
                   let cell  = cellAttribute.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
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

