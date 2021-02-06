//
//  Utilities.swift
//  AdayroiVendor
//
//  Created by MAC OSX on 12/8/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import UIKit
import TLCustomMask
import Foundation
import AnyFormatKit
@available(iOS 13.0, *)
class NavigationView{
    
    static func goForgotPassword() -> Void {
        let storyBoard = UIStoryboard(name: "User", bundle: nil)
        let objVC = storyBoard.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPassword
        let sideMenuViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
        appNavigation.setNavigationBarHidden(true, animated: true)
        let slideMenuController = SlideMenuController(mainViewController: appNavigation, leftMenuViewController: sideMenuViewController)
        slideMenuController.changeLeftViewWidth(UIScreen.main.bounds.width * 0.8)
        slideMenuController.removeLeftGestures()
        UIApplication.shared.windows[0].rootViewController = slideMenuController
    }
    static func goToSignupVC() -> Void {
           let storyBoard = UIStoryboard(name: "User", bundle: nil)
           let objVC = storyBoard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
           let sideMenuViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
           let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
           appNavigation.setNavigationBarHidden(true, animated: true)
           let slideMenuController = SlideMenuController(mainViewController: appNavigation, leftMenuViewController: sideMenuViewController)
           slideMenuController.changeLeftViewWidth(UIScreen.main.bounds.width * 0.8)
           slideMenuController.removeLeftGestures()
           UIApplication.shared.windows[0].rootViewController = slideMenuController
       }
    
    
}
