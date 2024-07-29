//
//  ViewModelOutput.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import RxSwift
import RxCocoa
protocol ViewModelOutput {
  associatedtype Outputs
  func callAsFunction() -> Outputs
}
protocol ViewModelCoordinator{
  associatedtype Coordinator
  var coordinator: Coordinator { get set }
}
