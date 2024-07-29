//
//  UIViewController+.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
extension UIViewController{
  /// Returns the current controller
  /// - Returns: Returns the current controller
  class func getCurrentVC() -> UIViewController {
      
      guard UIApplication.shared.keyWindow?.rootViewController == nil else {
          
          let rootViewController:UIViewController  = (UIApplication.shared.keyWindow?.rootViewController)!
          
          let currentVC:UIViewController = self.getCurrentVCFrom(rootVC: rootViewController)
          
          return currentVC
      }
      return UIViewController()
  }
  
  class func getCurrentVCFrom(rootVC:UIViewController) -> UIViewController {
      var currentVC:UIViewController
      
      if (rootVC.presentedViewController != nil) {
          currentVC = rootVC.presentedViewController!
      }
      if rootVC .isKind(of: UITabBarController.self) {
          let tabbar:UITabBarController = rootVC as!UITabBarController
          
          currentVC = self.getCurrentVCFrom(rootVC: tabbar.selectedViewController!)
      }else if rootVC .isKind(of: UINavigationController.self){
          let nav:UINavigationController = rootVC as!UINavigationController
          currentVC = self.getCurrentVCFrom(rootVC: nav.visibleViewController!)
      }else{
          currentVC = rootVC
      }
      
      return currentVC
  }
}
