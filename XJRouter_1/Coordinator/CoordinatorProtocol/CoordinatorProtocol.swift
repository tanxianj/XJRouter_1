//
//  CoordinatorProtocol.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
protocol CoordinatorProtocol{
  var navigationController:UINavigationController{get}
  var rootViewController:UIViewController{get}
  var mainCoordinator:MainCoordinator{get}
  var events:PublishSubject<CoordinatorEvents>{get}
  var disposeBag:DisposeBag{get}
  func setUpNavigationController()->Void
  func handleEvents()->Void
}
extension CoordinatorProtocol where Self:AnyObject{
  func handleEvents()->Void{
    self.events.asObservable().subscribe(onNext: { [weak self] events in
      guard let self = self else{return}
      self.mainCoordinator.events.onNext(events)
    }).disposed(by: self.disposeBag)
  }
}
