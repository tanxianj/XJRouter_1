//
//  HomeModule.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 23/2/24.
//

import Foundation
enum HomeModule:Int,ModuleProtocol{
  typealias Value = Int
  var value: Int{
    return self.rawValue
  }
  case home = 100
}
