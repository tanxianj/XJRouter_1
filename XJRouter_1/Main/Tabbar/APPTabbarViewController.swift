//
//  APPTabbarViewController.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import UIKit

class APPTabbarViewController: UITabBarController {

  let home = HomeCoordinator.sharedInstance()
  let favourite = FavouriteCoordinator.sharedInstance()
  let me = MeCoordinator.sharedInstance()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      if #available(iOS 15.0, *) {
          let tabbar = UITabBarAppearance()
          
          tabbar.shadowImage = UIImage()
          tabbar.shadowColor = .clear
          tabbar.backgroundImage = UIImage(named: "tab_back")
          tabbar.backgroundEffect = nil
          tabbar.stackedLayoutAppearance.selected.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12),.foregroundColor:UIColor.red]
          tabbar.stackedLayoutAppearance.selected.iconColor = .red
          tabbar.stackedLayoutAppearance.normal.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12),.foregroundColor:UIColor.black]
          self.tabBar.scrollEdgeAppearance = tabbar
          self.tabBar.standardAppearance = tabbar
      } else {
          // Fallback on earlier versions
          UITabBar.appearance().backgroundImage = UIImage()
          UITabBar.appearance().shadowImage = UIImage()
  //        UITabBar.appearance().backgroundColor = UIColor.appBGColor()
          self.tabBar.backgroundImage = UIImage(named: "tab_back")
          UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
          
      }
      self.tabBar.isTranslucent = false
      setUpUIViewController()
    }
    


}
private extension APPTabbarViewController{
  func setUpUIViewController(){
    let viewControllers = [home.navigationController,
                           favourite.navigationController,
                           me.navigationController]
    
    self.viewControllers = viewControllers
    
    
  }
}
