//
//  SideMenuVC.swift
//  WallPaperApp
//
//  Created by Mitesh's MAC on 23/12/19.
//  Copyright © 2019 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
struct MenuModel {
    let title: String
    let icon: String
    let viewController:UINavigationController
    let is_logout:Bool
    init(title:String,icon:String,viewController:UINavigationController,is_logout:Bool) {
        self.title = title
        self.icon = icon
        self.is_logout = is_logout
        self.viewController=viewController
        
    }
}
class MenuTableCell: UITableViewCell {
    @IBOutlet weak var lbl_menu: UILabel!
    @IBOutlet weak var img_menu: UIImageView!
}

class SideMenuVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tbl_menu: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    //MARK: Variables
    var menuArray = [String]()
    var menuImgeArray = [String]()
    var homeViewController = UINavigationController()
    var historyViewController = UINavigationController()
    var LoginViewController = UINavigationController()
    var SettingsViewController = UINavigationController()
    var RatingsViewController = UINavigationController()
    var FavoriteViewController = UINavigationController()
    var CategoryListViewController = UINavigationController()
    var BlogsViewController = UINavigationController()
    var MyProductViewController = UINavigationController()
    var list_item_menu:[MenuModel] = [MenuModel]()
    
    //MARK: Viewcontroller lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        var viewController=UINavigationController(rootViewController: homeVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Trang chủ", icon: "ic_Home",viewController: viewController,is_logout: false))
        
        
        let myProductListVC = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "MyProductListVC") as! MyProductListVC
        viewController = UINavigationController(rootViewController: myProductListVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Sản phẩm của tôi", icon: "ic_Home",viewController: viewController,is_logout: false))
        
        
        let ordersVC = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
        viewController = UINavigationController(rootViewController: ordersVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Quản lý đơn hàng", icon: "ic_OrderHistory",viewController: viewController,is_logout: false))
        
        
        
        let withdrawalListVC = UIStoryboard(name: "Withdrawal", bundle: nil).instantiateViewController(withIdentifier: "WithdrawalListVC") as! WithdrawalListVC
        viewController = UINavigationController(rootViewController: withdrawalListVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Rút tiền", icon: "ic_Home",viewController: viewController,is_logout: false))
        
        
        
        let settingsVC = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        viewController = UINavigationController(rootViewController: settingsVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Cài đặt", icon: "ic_settings",viewController: viewController,is_logout: false))
        

        let loginVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        viewController = UINavigationController(rootViewController: loginVC)
        viewController.setNavigationBarHidden(true, animated: true)
        self.list_item_menu.append(MenuModel(title: "Đăng xuất", icon: "ic_logout",viewController: viewController,is_logout: true))

        
     
        
        
        /*
         
         if UserDefaultManager.getStringFromUserDefaults(key: UD_isSkip) == "1"
         {
         if UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "en" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "N/A"
         {
         let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
         let viewController=UINavigationController(rootViewController: homeVC)
         viewController.setNavigationBarHidden(true, animated: true)
         self.list_item_menu.append(MenuModel(title: "Trang chủ", icon: "ic_Home",viewController: viewController, controler: homeVC))
         menuArray = ["Trang chủ","Rút tiền","Chia sẻ sản phẩm","sfs","Cài đặt"]
         menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings"]
         }
         else{
         //                menuArray = ["الصفحة الرئيسية","تاريخ الطلب","قائمة المفضلة","التقييمات","الإعدادات"]
         //                menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings"]
         menuArray = ["Home","Order History","Favorite List","Ratings","Settings"]
         menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings"]
         }
         }
         else{
         
         if UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "en" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "" || UserDefaultManager.getStringFromUserDefaults(key: UD_isSelectLng) == "N/A"
         {
         menuArray = ["Trang chủ","Rút tiền","Sản phẩm của tôi","Hướng dẫn","Thông tin tài khoản","Đăng xuất"]
         menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings","ic_logout"]
         }
         else{
         //                menuArray = ["الصفحة الرئيسية","تاريخ الطلب","قائمة المفضلة","التقييمات","الإعدادات","تسجيل خروج"]
         //                menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings","ic_logout"]
         menuArray = ["Home","Order History","Favorite List","Ratings","Settings","Logout"]
         menuImgeArray = ["ic_Home","ic_OrderHistory","ic_heart","ic_rate","ic_settings","ic_logout"]
         }
         
         
         }
         cornerRadius(viewName: self.imgProfile, radius: self.imgProfile.frame.height / 2)
         
         let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
         self.homeViewController = UINavigationController(rootViewController: homeVC)
         self.homeViewController.setNavigationBarHidden(true, animated: true)
         
         let withdrawalListVC = UIStoryboard(name: "Withdrawal", bundle: nil).instantiateViewController(withIdentifier: "WithdrawalListVC") as! WithdrawalListVC
         self.historyViewController = UINavigationController(rootViewController: withdrawalListVC)
         self.historyViewController.setNavigationBarHidden(true, animated: true)
         
         let LoginsVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
         self.LoginViewController = UINavigationController(rootViewController: LoginsVC)
         self.LoginViewController.setNavigationBarHidden(true,animated:true)
         
         
         let SettingVC = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
         self.SettingsViewController = UINavigationController(rootViewController: SettingVC)
         self.SettingsViewController.setNavigationBarHidden(true,animated:true)
         
         let rateVC = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "RatingsVC") as! RatingsVC
         self.RatingsViewController = UINavigationController(rootViewController: rateVC)
         self.RatingsViewController.setNavigationBarHidden(true,animated:true)
         
         let FavoritesVC = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "FavoriteListVC") as! FavoriteListVC
         self.FavoriteViewController = UINavigationController(rootViewController: FavoritesVC)
         self.FavoriteViewController.setNavigationBarHidden(true,animated:true)
         
         let CategoryListVC = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "CategoryListVC") as! CategoryListVC
         self.CategoryListViewController = UINavigationController(rootViewController: CategoryListVC)
         self.CategoryListViewController.setNavigationBarHidden(true,animated:true)
         
         let BlogsVC = UIStoryboard(name: "Blogs", bundle: nil).instantiateViewController(withIdentifier: "BlogsVC") as! BlogsVC
         self.BlogsViewController = UINavigationController(rootViewController: BlogsVC)
         self.BlogsViewController.setNavigationBarHidden(true,animated:true)
         
         let myProductListVC = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "MyProductListVC") as! MyProductListVC
         self.MyProductViewController = UINavigationController(rootViewController: myProductListVC)
         self.MyProductViewController.setNavigationBarHidden(true,animated:true)
         */
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UserDefaultManager.getStringFromUserDefaults(key: UD_isSkip) != "1"
        {
            
            let urlString = API_URL + "/api/users/"+String(UserDefaults.standard.value(forKey: UD_userId) as! String)
            let params: NSDictionary = [:]
            self.Webservice_GetProfile(url: urlString, params: params)
        }
    }
}

//MARK: Tableview methods
extension SideMenuVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list_item_menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell") as! MenuTableCell
        let menuModel:MenuModel=self.list_item_menu[indexPath.row]
        cell.lbl_menu.text = menuModel.title
        cell.img_menu.image = UIImage.init(named: menuModel.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuModel:MenuModel=self.list_item_menu[indexPath.row]
        if(menuModel.is_logout){
             UserDefaultManager.setStringToUserDefaults(value: "", key: UD_userId)
        }
        self.slideMenuController()?.changeMainViewController(menuModel.viewController, close: true)
    }
}
//MARK: Webservices
extension SideMenuVC {
    func Webservice_GetProfile(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: "", messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let responseData = jsonResponse!["data"].dictionaryValue
                    print(responseData)
                    self.imgProfile.sd_setImage(with: URL(string: responseData["profile_image"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
                    self.lblUsername.text = responseData["name"]?.stringValue
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
}
