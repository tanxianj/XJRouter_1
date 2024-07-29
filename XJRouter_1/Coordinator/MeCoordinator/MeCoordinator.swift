//
//  MeCoordinator.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MeCoordinator:CoordinatorProtocol{
  private static var _sharedInstance:MeCoordinator?
  
  /// 单列
  /// - Returns: BasePoputView
  class func sharedInstance()->MeCoordinator{
      guard let Instance = _sharedInstance else {
          _sharedInstance = MeCoordinator()
          return _sharedInstance!
      }
      return Instance
  }
  
  /// 销毁单列
  func deInstance(){
    MeCoordinator._sharedInstance = nil
  }
  var navigationController: UINavigationController = UINavigationController()
  var rootViewController: UIViewController = UIViewController()
  var mainCoordinator: MainCoordinator = MainCoordinator()
  
  var events: PublishSubject<CoordinatorEvents> = PublishSubject<CoordinatorEvents>()
  
  var disposeBag:DisposeBag =  DisposeBag()
  
  private init(){
    setUpNavigationController()
    handleEvents()
  }
  
}
extension MeCoordinator{
  func setUpNavigationController() {
    //let meVc = UIStoryboard(name: "MeViewController", bundle: nil).instantiateViewController(withIdentifier: "MeViewController")
    let meVc = MeViewController.initViewControllerWith(parameter:"")
    meVc.navigationItem.title = "Me"
    meVc.tabBarItem.title = "Me"
    meVc.tabBarItem.selectedImage = UIImage(named: "我的")?.withRenderingMode(.alwaysOriginal)
    meVc.tabBarItem.image = UIImage(named: "我的-1")?.withRenderingMode(.alwaysOriginal)
    self.rootViewController = meVc
    let nav = APPNavigationController(rootViewController: meVc)
    self.navigationController = nav
  }
}
