//
//  HomeCoordinator.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class HomeCoordinator:CoordinatorProtocol{
  private static var _sharedInstance:HomeCoordinator?
  
  /// 单列
  /// - Returns: BasePoputView
  class func sharedInstance()->HomeCoordinator{
      guard let Instance = _sharedInstance else {
          _sharedInstance = HomeCoordinator()
          return _sharedInstance!
      }
      return Instance
  }
  
  /// 销毁单列
  func deInstance(){
    HomeCoordinator._sharedInstance = nil
  }
  
  var disposeBag: DisposeBag =  DisposeBag()
  var rootViewController: UIViewController = UIViewController()
  var navigationController: UINavigationController = UINavigationController()
  
  var mainCoordinator: MainCoordinator = MainCoordinator()
  
  var events: PublishSubject<CoordinatorEvents> =  PublishSubject<CoordinatorEvents>()
  
  private init(){
    setUpNavigationController()
    handleEvents()
  }
  
}
extension HomeCoordinator{
  func setUpNavigationController() {
    
    var homeVc = UIViewController()
    if let clsName = ModuleManager.sharedInstance().getVCNameWith(module: HomeModule.home),
       let cls = clsName.toClass() as? any ViewControllerCoordinator.Type {
      print("cls is \(cls.module)")
      homeVc = cls.initViewControllerWith(parameter:nil)
    }
    //let homeVc = HomeViewController.initViewControllerWith(parameter:nil)//UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
    homeVc.navigationItem.title = "Home"
    homeVc.tabBarItem.title = "Home"
    homeVc.tabBarItem.selectedImage = UIImage(named: "首页")?.withRenderingMode(.alwaysOriginal)
    homeVc.tabBarItem.image = UIImage(named: "首页-1")?.withRenderingMode(.alwaysOriginal)
    self.rootViewController = homeVc
    let nav = APPNavigationController(rootViewController: homeVc)
    self.navigationController = nav
  }
}
