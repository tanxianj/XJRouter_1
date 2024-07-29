//
//  MainCoordinator.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import RxSwift
import RxCocoa
class MainCoordinator{
  let events = PublishSubject<CoordinatorEvents>()
  private let disposeBag = DisposeBag()
  init(){
    self.events.subscribe(onNext: { [weak self] events in
      guard let self = self,let nav = UIViewController.getCurrentVC().navigationController else{return}
      switch events {
        case .pop(let animated):
          nav.popViewController(animated: animated)
        case .popToRooter(let animated):
          nav.popToRootViewController(animated: animated)
        case .pushToModule(let module,let parameter, let animated):
          guard let vcName =  ModuleManager.sharedInstance().getVCNameWith(module: module) else{return}
          guard let cls = vcName.toClass() as? ViewControllerCoordinator.Type else { return }
          nav.pushViewController(cls.initViewControllerWith(parameter: parameter), animated: animated)
          break
        case .popToModule(let module, let animated):
          guard let vcName =  ModuleManager.sharedInstance().getVCNameWith(module: module) else{return}
          if let vc =  nav.viewControllers.first(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == vcName}){
            nav.popToViewController(vc, animated: animated)
          }
        case .pushTo(let coordinator,let parameter, let animated):
          let rootVc = coordinator.rootViewController
          
          if let clsName = NSStringFromClass(type(of: rootVc)).components(separatedBy: ".").last,
             let cls = clsName.toClass() as? ViewControllerCoordinator.Type {
             let vc = cls.initViewControllerWith(parameter: parameter)
             nav.pushViewController(vc, animated: animated)
          }
          break
        case .popTo(let coordinator, let animated):
          let rootVc = coordinator.rootViewController
          if nav.viewControllers.contains(rootVc){
            nav.popToViewController(rootVc, animated: animated)
          }else if let clsName = NSStringFromClass(type(of: rootVc)).components(separatedBy: ".").last,
                   let vc = nav.viewControllers.first(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == clsName}){
            nav.popToViewController(vc, animated: animated)
          }
          
          break
        case .insterModuleWithBefor(let module, let parameter,let withBefor):
          guard let withBeforVcName =  ModuleManager.sharedInstance().getVCNameWith(module: withBefor) else{return}
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == withBeforVcName}){
            if let vcName = ModuleManager.sharedInstance().getVCNameWith(module: module),
               let vc = vcName.toClass() as? ViewControllerCoordinator.Type {
              nav.viewControllers.insert(vc.initViewControllerWith(parameter: parameter), at: index)
            }
          }
          break
        case .insterCoordinatorWithBefor(let coordinator,let parameter, let withCoordinatorBefor):
          let beforVC = withCoordinatorBefor.rootViewController
          let beforVCName = (NSStringFromClass(type(of: beforVC)).components(separatedBy: ".").last)
          
          let targetVC = coordinator.rootViewController
          let targetVCName = (NSStringFromClass(type(of: targetVC)).components(separatedBy: ".").last)
          
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == beforVCName}){
            let allModuleElement = ModuleManager.sharedInstance().getAllModuleElement()
            if let element = allModuleElement.first(where: {$0.vcName == targetVCName}),
               let vc = element.vcName.toClass() as? ViewControllerCoordinator.Type {
              nav.viewControllers.insert(vc.initViewControllerWith(parameter: parameter), at: index)
            }
          }
          
          break
        case .insterModuleWithModuleAfter(let module, let parameter,let withModuleAfter):
          guard let withModuleAfterVcName =  ModuleManager.sharedInstance().getVCNameWith(module: withModuleAfter) else{return}
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == withModuleAfterVcName}){
            if let vcName = ModuleManager.sharedInstance().getVCNameWith(module: module),
               let vc = vcName.toClass() as? ViewControllerCoordinator.Type {
              nav.viewControllers.insert(vc.initViewControllerWith(parameter: parameter), at: index + 1)
            }
          }
          break
        case .insterCoordinatorWithCoordinatorAfter(let coordinator,let parameter, let withCoordinatorAfter):
          let beforVC = withCoordinatorAfter.rootViewController
          let beforVCName = (NSStringFromClass(type(of: beforVC)).components(separatedBy: ".").last)
          
          let targetVC = coordinator.rootViewController
          let targetVCName = (NSStringFromClass(type(of: targetVC)).components(separatedBy: ".").last)
          
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == beforVCName}),
             nav.viewControllers.count >= index + 1{
            let allModuleElement = ModuleManager.sharedInstance().getAllModuleElement()
            if let element = allModuleElement.first(where: {$0.vcName == targetVCName}),
               let vc = element.vcName.toClass() as? ViewControllerCoordinator.Type {
              nav.viewControllers.insert(vc.initViewControllerWith(parameter: parameter), at: index + 1)
            }
          }
        case .removeModuleWithModuleBefor(let module, let withBefor):
          guard let withBeforVcName =  ModuleManager.sharedInstance().getVCNameWith(module: withBefor) else{return}
          guard let moduleVcName =  ModuleManager.sharedInstance().getVCNameWith(module: module) else{return}
          
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == withBeforVcName}),
             let moduleIndex =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == moduleVcName}),
             index > moduleIndex {
              nav.viewControllers.remove(at: moduleIndex)
          }
          break
        case .removerCoordinatorWithCoordinatorBefor(let coordinator, let withCoordinatorBefor):
          break
        case .removeModuleWithModuleAfter(let module, let withModuleAfter):
          guard let withModuleAfterVcName =  ModuleManager.sharedInstance().getVCNameWith(module: withModuleAfter) else{return}
          guard let moduleVcName =  ModuleManager.sharedInstance().getVCNameWith(module: module) else{return}
          
          if let index =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == withModuleAfterVcName}),
             let moduleIndex =  nav.viewControllers.firstIndex(where: {NSStringFromClass(type(of: $0)).components(separatedBy: ".").last == moduleVcName}),
             index < moduleIndex {
              nav.viewControllers.remove(at: moduleIndex)
          }
        case .removeCoordinatorWithCoordinatorAfter(let coordinator, let withCoordinatorAfter):
          break
        case .popToRootThenSelectTabBarIndex(let index):
          guard let tabbar = UIViewController.getCurrentVC().tabBarController else{return}
          tabbar.selectedIndex = index
          break
      }
      
    }).disposed(by: self.disposeBag)
  }
}
