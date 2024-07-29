//
//  APPNavigationController+.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 26/2/24.
//

import Foundation
import UIKit
class APPNavigationController:UINavigationController,UINavigationControllerDelegate, UIGestureRecognizerDelegate{
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 15.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.backgroundColor = .white
      navBarAppearance.backgroundEffect = nil
      navBarAppearance.shadowColor = .clear
      navBarAppearance.titleTextAttributes = [.foregroundColor:UIColor.black,.font:UIFont.systemFont(ofSize: 20, weight: .semibold)]
      self.navigationBar.scrollEdgeAppearance = navBarAppearance
      self.navigationBar.standardAppearance = navBarAppearance
    } else {
      // Fallback on earlier versions
      self.interactivePopGestureRecognizer?.delegate = self
      self.delegate = self
      //        UINavigationBar.appearance().backgroundColor = UIColor.white
      self.navigationBar.barTintColor = UIColor.white
      self.navigationBar.shadowImage = UIImage()
      //        self.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black, .font :UIFont(name: "PingFangTC-Semibold", size: 20), /*.backgroundColor:UIColor.red*/]
      self.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black, .font :UIFont.systemFont(ofSize: 20, weight: .semibold)]
    }
    self.navigationBar.isTranslucent = false
    
    
  }
  // 重写这两个方法 修复 控制 preferredStatusBarStyle 方法无效
  override var childForStatusBarHidden: UIViewController? {
    return topViewController
  }
  
  override var childForStatusBarStyle: UIViewController? {
    return topViewController
  }
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if self.viewControllers.count > 0 {
      viewController.hidesBottomBarWhenPushed = true
    }
    super.pushViewController(viewController, animated: true)
  }
  override func popViewController(animated: Bool) -> UIViewController? {
    let vc = super.popViewController(animated: animated)
    print("APPNavigationController vcs is \(NSStringFromClass(type(of: vc!)).components(separatedBy: ".").last)")
    return vc
  }
}
