//
//  ViewController+Coordinator.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 23/2/24.
//

import Foundation
import UIKit
protocol ViewControllerCoordinator{
  typealias Module = ModuleProtocol
  static var module:any Module{get}
  static func initViewControllerWith(parameter:Any?)->UIViewController
  static func vcName()->String
}
extension ViewControllerCoordinator where Self:AnyObject{
  static func vcName()->String{
    let vcName = NSStringFromClass(Self.self).components(separatedBy: ".").last
    return vcName ?? "nil"
  }
  
}
