 //
 //  OrderHistoryVC.swift
 //  AdayroiVendor
 //
 //  Created by Mitesh's MAC on 07/06/20.
 //  Copyright © 2020 Mitesh's MAC. All rights reserved.
 //
 
 import UIKit
 import SwiftyJSON
 import Foundation
 import AnyFormatKit
 
 
 class ProductLabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UILabelText: UILabel!
    static let reuseID = "ProductLabelCollectionViewCell"
 }
 
 class ProductButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var UIButtonWithDrawal: UIButton!
    static let reuseID = "ProductButtonCollectionViewCell"
 }
 
 //MARK: - Properties
 private enum Properties {
    static let verticalMargin: CGFloat = 5
    static let horizontalMargin: CGFloat = 15
    static let widthConstant: CGFloat = 20
 }
 class MyProductListVC: UIViewController {
    var OrderHistoryData = [JSON]()
    var selected = String()
    var list_product:[ProductModel]=[ProductModel]();
    @IBOutlet weak var UIViewLichSuRutTien: UIView!
    @IBOutlet weak var UILabelSoTienCoTheRut: UILabel!
    @IBOutlet weak var UILabelSoTIenDangSuLy: UILabel!
    @IBOutlet weak var UIButtonCaiDatTkNganHang: UIButton!
    @IBOutlet weak var UIButtonLapLenhRutTien: UIButton!
    
    @IBAction func TouchUpInsideLapLenhRutTien(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EditProductVC") as! EditProductVC
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .crossDissolve
        VC.delegate = self
        
        self.present(VC,animated: true,completion: nil)
    }
    @IBAction func TouchUpInSideCaiDatTKNganHang(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalCaiDatTKNganHangVC") as! WithdrawalCaiDatTKNganHangVC
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .crossDissolve
        self.present(VC,animated: true,completion: nil)
    }
    @IBOutlet weak var gridCollectionView: UICollectionView! {
        didSet {
            gridCollectionView.bounces = false
        }
    }
    
    
    var headerTitles:[CellProduct]=[CellProduct]()
    var list_cell_product:[[CellProduct]]=[[CellProduct]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selected = ""
        self.headerTitles = [
            CellProduct(title: "Stt",is_head: true,columnType: "", columnName: "stt",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Tên sản phẩm",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Mã sản phẩm",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Ảnh sản phẩm",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Danh mục cha sản phẩm",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Danh mục con sản phẩm",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Giá thường bán",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Phần trăm giảm giá",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Giá bán của shop",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Sửa",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
            CellProduct(title: "Xóa",is_head: true,columnType: "", columnName: "",action:  #selector(self.nothing(_:)))
            
        ]
        gridCollectionView.delegate=self
        gridCollectionView.dataSource=self
        self.list_cell_product.append(self.headerTitles)
        
        var nibCell = UINib(nibName:ProductEditCollectionViewCell.reuseID, bundle: nil)
        self.gridCollectionView.register(nibCell, forCellWithReuseIdentifier: ProductEditCollectionViewCell.reuseID)
        
        nibCell = UINib(nibName:ProductShowContentCollectionViewCell.reuseID, bundle: nil)
        self.gridCollectionView.register(nibCell, forCellWithReuseIdentifier: ProductShowContentCollectionViewCell.reuseID)
        
        nibCell = UINib(nibName:ProductDeleteCollectionViewCell.reuseID, bundle: nil)
        self.gridCollectionView.register(nibCell, forCellWithReuseIdentifier: ProductDeleteCollectionViewCell.reuseID)
        
        nibCell = UINib(nibName:ProductImageCollectionViewCell.reuseID, bundle: nil)
        self.gridCollectionView.register(nibCell, forCellWithReuseIdentifier: ProductImageCollectionViewCell.reuseID)
        
        
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendorproducts?user_id=\(user_id)&limit=30&offset=0"
        self.Webservice_GetMyProducts(url: urlString, params:[:])
        
        
        
    }
    @objc private func refreshData(_ sender: Any) {
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendorproducts?user_id=\(user_id)&limit=30&offset=0"
        self.Webservice_GetMyProducts(url: urlString, params:[:])
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("hello viewWillAppear")
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendorproducts?user_id=\(user_id)&limit=30&offset=0"
        self.Webservice_GetMyProducts(url: urlString, params:[:])
        
        
        
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
    @objc func nothing(_ sender: UIButton){
        print("hello34343")
        
    }
    @objc func deleteProduct(_ sender: UIButton){
        
        
    }
    @objc func editProduct(_ sender: UIButton){
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EditProductVC") as! EditProductVC
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .crossDissolve
        VC.delegate = self
        VC.ProductId=self.list_product[sender.tag-1]._id
        self.present(VC,animated: true,completion: nil)
    }
    
    
    
 }
 
 extension MyProductListVC: AddNewProductDelegate {
    
    func refreshData() {
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
        let urlString = API_URL + "/api/vendorproducts?user_id=\(user_id)&limit=30&offset=0"
        self.Webservice_GetMyProducts(url: urlString, params:[:])
        
        
    }
 }
 
 //MARK: WithdrawalList
 extension MyProductListVC {
    
    
    func Webservice_GetMyProducts(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getApiRespondeMyProductsModel = try jsonDecoder.decode(GetApiRespondeMyProductsModel.self, from: jsonResponse!)
                    self.list_product=getApiRespondeMyProductsModel.list_product
                    self.list_cell_product=[[CellProduct]]()
                    var i=0;
                    self.list_cell_product.append(self.headerTitles)
                    let dataButton = UIButton()
                    dataButton.backgroundColor = UIColor( red: CGFloat(92/255.0), green: CGFloat(203/255.0), blue: CGFloat(207/255.0), alpha: CGFloat(1.0) )
                    dataButton.layer.cornerRadius = 5
                    dataButton.sizeToFit()
                    //dataButton.addTarget(self, action: #selector(btnTapMines), for: .touchUpInside)
                    
                    
                    
                    dataButton.setTitle("Xóa", for: .normal)
                    dataButton.translatesAutoresizingMaskIntoConstraints = false
                    
                    
                    
                    for product in self.list_product {
                    
                        self.list_cell_product.append([
                            CellProduct(title: "Stt",is_head: false,columnType: "", columnName: "stt",action:  #selector(self.nothing(_:))),
                            CellProduct(title: product.name,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title: product.code,is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title:  product.default_photo?.img_path ??  "",is_head: false,columnType: "", columnName: "image",action:  #selector(self.nothing(_:))),
                            CellProduct(title: product.category?.name ?? "",is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title: product.subCategory?.name ?? "",is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title: LibraryUtilitiesUtility.format_currency(amount: UInt64(product.original_price),decimalCount: 0),is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title: String(product.commistion),is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title:LibraryUtilitiesUtility.format_currency(amount: UInt64(product.unit_price),decimalCount: 0),is_head: false,columnType: "", columnName: "",action:  #selector(self.nothing(_:))),
                            CellProduct(title: "Sửa",is_head: false,columnType: "", columnName: "edit",action:  #selector(self.editProduct(_:))),
                            CellProduct(title: "Xóa",is_head: false,columnType: "", columnName: "delete",action:  #selector(self.deleteProduct(_:)))
                        ])
                        i += 1
                    }
                    
                    
                    self.gridCollectionView.reloadData()
                    
                    
                    
                } catch let error as NSError  {
                    print("error: \(error)")
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
        
        
        
        
        
        
    }
    func Webservice_GetDeleteWithdrawal(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getDeletewithdrawalModel = try jsonDecoder.decode(GetDeletewithdrawalModel.self, from: jsonResponse!)
                    debugPrint("getDeletewithdrawalModel \(getDeletewithdrawalModel)")
                    if(getDeletewithdrawalModel.result=="error"){
                        showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: getDeletewithdrawalModel.errorMessage)
                    }else{
                        showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Đã xóa thành công")
                    }
                    let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId);
                    
                    let urlString = API_URL + "/api/withdrawals/list?user_id=\(user_id)&limit=30&offset=0"
                    self.Webservice_GetMyProducts(url: urlString, params:[:])
                    
                    
                    
                } catch let error as NSError  {
                    print("error: \(error)")
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
        
        
        
        
        
        
    }
    
    
    @objc func btnTapMines(sender:UIButton)
    {
        
        
        
        
        
    }
 }
 
 extension MyProductListVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.list_cell_product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list_cell_product[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let CellProduct:CellProduct=self.list_cell_product[indexPath.section][indexPath.row]
        let cell  = CellProduct.getUICollectionViewCell(collectionView: collectionView,indexPath: indexPath)
        return cell
        
        
        
        
        
    }
 }
 
 extension MyProductListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:300, height: 40)
    }
 }
