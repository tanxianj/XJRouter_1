//
//  HomeViewController.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import UIKit

class HomeViewController: UIViewController,MVVMViewProtocol {
  var viewModel: HomeViewModel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //viewModel = HomeViewModel()
    let vcs = self.navigationController?.viewControllers
    vcs?.forEach({ vcs in
      print("home vcs is \(NSStringFromClass(type(of: vcs)).components(separatedBy: ".").last)")
    })
    ModuleManager.sharedInstance().getAllModuleElement().forEach { element in
      print("element is \(element.module),\(element.vcName)")
    }
    let vcName =  ModuleManager.sharedInstance().getVCNameWith(module: HomeModule.home)
    print("vcName is \(vcName)")
    
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func btn1(_ sender: Any) {
    self.dispatch(HomeViewModelInputEvent.back)
  }
  
  @IBAction func btn2(_ sender: Any) {
    self.dispatch(HomeViewModelInputEvent.gotoMe)
  }
}
extension HomeViewController:ViewControllerCoordinator{
  static var module: any Module {
    return HomeModule.home
  }
  
  static func initViewControllerWith(parameter:Any?) -> UIViewController {
    let vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    vc.viewModel = HomeViewModel()
    return vc
  }
  
  
}
