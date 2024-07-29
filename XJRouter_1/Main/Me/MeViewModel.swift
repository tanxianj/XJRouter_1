//
//  MeViewModel.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 26/2/24.
//

import Foundation
import RxSwift
import RxCocoa
enum MeViewModelInputEvent:InputEvent{
  case back
  case backtoHome
  case pushToFavourite
  case pushtofavouritecoordinator
  case poptoHomecoordinator
}

class MeViewModel:MVVMVMProtocol{
  
  typealias Coordinator = MeCoordinator
  
  lazy var coordinator:Coordinator = {
    MeCoordinator.sharedInstance()
  }()
 
  init(parameter:Any?){
    print("Me VM  data is \(parameter)")
  }
  
  typealias Outputs = (
  
  )
  
  func callAsFunction() -> () {
    
    
  }
  
  
  func handleEvent(event: InputEvent) {
    if let event = event as? MeViewModelInputEvent{
      switch event {
        case .back:
          print("back")
        case .backtoHome:
          print("me")
//          coordinator.events.onNext(.pushToCoordinator(MeCoordinator.sharedInstance()))
          coordinator.events.onNext(.popToModule(module: HomeModule.home, animated: true))
        case .pushToFavourite:
          coordinator.events.onNext(.pushToModule(module: FavouriteModule.favourite, animated: true))
        case .pushtofavouritecoordinator:
          //coordinator.events.onNext(.pushTo(coordinator: FavouriteCoordinator.sharedInstance(), animated: true))
          //coordinator.events.onNext(.insterCoordinatorWithBefor(coordinator: FavouriteCoordinator.sharedInstance(), withCoordinatorBefor: MeCoordinator.sharedInstance()))
          coordinator.events.onNext(.insterCoordinatorWithCoordinatorAfter(coordinator: FavouriteCoordinator.sharedInstance(), withCoordinatorAfter: HomeCoordinator.sharedInstance()))
        case .poptoHomecoordinator:
          coordinator.events.onNext(.popTo(coordinator: HomeCoordinator.sharedInstance(), animated: true))
      }
    }
  }
  
  
}
