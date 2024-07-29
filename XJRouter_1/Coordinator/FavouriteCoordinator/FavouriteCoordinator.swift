//
//  FavouriteCoordinator.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FavouriteCoordinator:CoordinatorProtocol{
  private static var _sharedInstance:FavouriteCoordinator?
  
  /// 单列
  /// - Returns: BasePoputView
  class func sharedInstance()->FavouriteCoordinator{
      guard let Instance = _sharedInstance else {
          _sharedInstance = FavouriteCoordinator()
          return _sharedInstance!
      }
      return Instance
  }
  
  /// 销毁单列
  func deInstance(){
    FavouriteCoordinator._sharedInstance = nil
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
extension FavouriteCoordinator{
  func setUpNavigationController() {
    //let favourite = UIStoryboard(name: "FavouriteViewController", bundle: nil).instantiateViewController(withIdentifier: "FavouriteViewController")
    let favourite = FavouriteViewController.initViewControllerWith(parameter:nil)
    favourite.navigationItem.title = "favourite"
    favourite.tabBarItem.title = "favourite"
    favourite.tabBarItem.selectedImage = UIImage(named: "Tab_Downloads_Selected")?.withRenderingMode(.alwaysOriginal)
    favourite.tabBarItem.image = UIImage(named: "Tab_Downloads")?.withRenderingMode(.alwaysOriginal)
    
    self.rootViewController = favourite
    let nav = APPNavigationController(rootViewController: favourite)
    self.navigationController = nav
  }
}
