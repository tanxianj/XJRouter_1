//
//  InputEventDispatch.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import UIKit

protocol InputEvent {}

protocol InputEventDispatch {
  func dispatch(_ action: InputEvent) -> Void
}

protocol InputEventHandler {
  func handleEvent(event: InputEvent) -> Void
}

