//
//  MeModule.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 26/2/24.
//

import Foundation
enum MeModule:Int,ModuleProtocol{
  typealias Value = Int
  var value: Int{
    return self.rawValue
  }
  case me = 200
}
