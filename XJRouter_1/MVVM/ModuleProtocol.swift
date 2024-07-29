//
//  ModuleProtocol.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 23/2/24.
//

import Foundation
protocol ModuleProtocol{
  associatedtype Value :Equatable
  var value:Value{get}
}
class ModuleManager{
  private static var _sharedInstance:ModuleManager?
  
  /// 单列
  /// - Returns: BasePoputView
  class func sharedInstance()->ModuleManager{
      guard let Instance = _sharedInstance else {
          _sharedInstance = ModuleManager()
          return _sharedInstance!
      }
      return Instance
  }
  private var moduleElement:[APPModuleElement] = []
  private init(){}
  
  func updateWith(module:any ModuleProtocol,vcName:String)->Void{
    
    if let moduleValue = module.value as? Int,
       !self.moduleElement.contains(where: {$0.module.value as! Int == moduleValue}){
      self.moduleElement.append(APPModuleElement(module: module, vcName: vcName))
    }
  }
  func getVCNameWith(module:any ModuleProtocol)->String?{
    guard let value = module.value as? Int,
          let model = self.moduleElement.first(where: {$0.module.value as! Int == value}) else { return nil }
    return model.vcName
  }
  func getAllModuleElement()->[APPModuleElement]{
    return self.moduleElement
  }
}
struct APPModuleElement{
  var module:any ModuleProtocol
  var vcName:String
}
