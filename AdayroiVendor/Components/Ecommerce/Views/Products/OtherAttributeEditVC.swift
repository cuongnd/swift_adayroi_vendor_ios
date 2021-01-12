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

protocol OtherAttributeEditDelegate {
    func refreshData(otherAttributeHeadIndex:Int,otherAttributeTitleHeadIndex:Int,otherAttributeHead:[CellOrtherHeadAttribute])
}

class OtherAttributeEditVC: UIViewController {
    
    @IBOutlet weak var btn_ok: UIButton!
    var delegate: OtherAttributeEditDelegate!
    @IBOutlet weak var UITextFieldAttributeName: UITextField!
    @IBOutlet weak var UITextViewDescription: UITextView!
    var userAffiliateInfoModel:UserAffiliateInfoModel=UserAffiliateInfoModel()
    var customMask = TLCustomMask()
    var otherAttributeHeadIndex:Int = -1
    var otherAttributeTitleHeadIndex:Int = -1
    var otherAttributeHead:[CellOrtherHeadAttribute]=[CellOrtherHeadAttribute]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UITextFieldAttributeName.text=otherAttributeHead[1].title
        self.UITextViewDescription.text=otherAttributeHead[2].title
        /*
        let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
        print(" ")
        phoneFormatter.format("+123456789012") /
        */
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

       
    }
    
    @IBAction func btnTap_Ok(_ sender: UIButton) {
        var attributeName=String(self.UITextFieldAttributeName.text!)
        var description=String(self.UITextViewDescription.text!)
        
        attributeName = String(attributeName.filter { !" \n\t\r".contains($0) })
        description = String(description.filter { !" \n\t\r".contains($0) })

        
        if(attributeName==""){
            UITextFieldAttributeName.text="";
            UITextFieldAttributeName.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên thuộc tính", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
       
        if(description==""){
               UITextViewDescription.text="";
               UITextViewDescription.becomeFirstResponder()
               let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập các giá trị cho thuộc tính", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
               self.present(alert, animated: true)
               
               return
           }
        self.otherAttributeHead[1].title=attributeName
        otherAttributeHead[2].title=description
        self.dismiss(animated: true) {
            self.delegate.refreshData(otherAttributeHeadIndex: self.otherAttributeHeadIndex,otherAttributeTitleHeadIndex:self.otherAttributeTitleHeadIndex, otherAttributeHead: self.otherAttributeHead)
        }
        
      }
    
    @IBAction func btnTap_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}



extension OtherAttributeEditVC: UITextFieldDelegate{
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        self.UITextFieldAttributeName.text = customMask.formatStringWithRange(range: range, string: string)

        return false
    }
}
