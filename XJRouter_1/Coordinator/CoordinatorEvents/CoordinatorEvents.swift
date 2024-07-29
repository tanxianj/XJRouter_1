//
//  CoordinatorEvents.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
enum CoordinatorEvents{
  case pop(animated: Bool = true)
  
  case popToRooter(animated: Bool = true)
  
  case pushToModule(module:any ModuleProtocol,parameter:Any? = nil,animated: Bool = true)
  case popToModule(module:any ModuleProtocol,animated: Bool = true)
  
  case pushTo(coordinator:CoordinatorProtocol,parameter:Any? = nil,animated: Bool = true)
  case popTo(coordinator:CoordinatorProtocol,animated: Bool = true)
  
  case insterModuleWithBefor(module:any ModuleProtocol,parameter:Any? = nil,withBefor:any ModuleProtocol)
  case insterCoordinatorWithBefor(coordinator:CoordinatorProtocol,parameter:Any? = nil,withCoordinatorBefor:CoordinatorProtocol)
  
  case insterModuleWithModuleAfter(module:any ModuleProtocol,parameter:Any? = nil,withModuleAfter:any ModuleProtocol)
  case insterCoordinatorWithCoordinatorAfter(coordinator:CoordinatorProtocol,data:Any? = nil,withCoordinatorAfter:CoordinatorProtocol)
  
  case removeModuleWithModuleBefor(module:any ModuleProtocol,withModuleBefor:any ModuleProtocol)
  case removerCoordinatorWithCoordinatorBefor(coordinator:CoordinatorProtocol,withCoordinatorBefor:CoordinatorProtocol)
  
  case removeModuleWithModuleAfter(module:any ModuleProtocol,withModuleAfter:any ModuleProtocol)
  case removeCoordinatorWithCoordinatorAfter(coordinator:CoordinatorProtocol,withCoordinatorAfter:CoordinatorProtocol)
  
  case popToRootThenSelectTabBarIndex(index:Int)
}
