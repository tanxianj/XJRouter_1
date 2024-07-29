//
//  ViewProtocol.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit
protocol MVVMViewProtocol:InputEventDispatch{
  associatedtype ViewModel
  var viewModel: ViewModel! { get set }

  
}
extension MVVMViewProtocol where ViewModel:MVVMVMProtocol{
  func dispatch(_ action: InputEvent) -> Void {
    viewModel.handleEvent(event: action)
  }
}
