//
//  FavouriteViewModel.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 26/2/24.
//

import Foundation
import RxSwift
import RxCocoa
enum FavouriteViewModelInputEvent:InputEvent{
  case back
  case backtoHome
  case backToMe
}

class FavouriteViewModel:MVVMVMProtocol{
  
  typealias Coordinator = FavouriteCoordinator
  
  lazy var coordinator:Coordinator = {
    FavouriteCoordinator.sharedInstance()
  }()
 
  
  init(){
    
  }
  
  typealias Outputs = (
  
  )
  
  func callAsFunction() -> () {
    
    
  }
  
  
  func handleEvent(event: InputEvent) {
    if let event = event as? FavouriteViewModelInputEvent{
      switch event {
        case .back:
          print("back")
        case .backtoHome:
          //coordinator.events.onNext(.removeModuleWithModuleAfter(module: MeModule.me, withModuleAfter: HomeModule.home))
//          coordinator.events.onNext(.popTo(coordinator: HomeCoordinator.sharedInstance(), animated: true))
          coordinator.events.onNext(.popToModule(module: HomeModule.home))
        case .backToMe:
          //coordinator.events.onNext(.popToModule(module: MeModule.me, animated: true))
          coordinator.events.onNext(.popTo(coordinator: MeCoordinator.sharedInstance(), animated: true))
      }
    }
  }
  
  
}
