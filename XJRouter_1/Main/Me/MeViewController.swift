//
//  MeViewController.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import UIKit

class MeViewController: UIViewController,MVVMViewProtocol {
  var viewModel: MeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.title = "Me"
      //viewModel = MeViewModel(data: nil)
      let vcs = self.navigationController?.viewControllers
      vcs?.forEach({ vcs in
        print("Me vcs is \(vcs)")
      })
        // Do any additional setup after loading the view.
    }
    
  @IBAction func pushtoFavourite(_ sender: Any) {
    dispatch(MeViewModelInputEvent.pushToFavourite)
  }
  @IBAction func popToHome(_ sender: Any) {
    dispatch(MeViewModelInputEvent.backtoHome)
  }
  
  @IBAction func pushtofavouritecoordinator(_ sender: Any) {
    dispatch(MeViewModelInputEvent.pushtofavouritecoordinator)
  }
  
  @IBAction func poptoHomecoordinator(_ sender: Any) {
    dispatch(MeViewModelInputEvent.poptoHomecoordinator)
  }
  
}
extension MeViewController:ViewControllerCoordinator{
  static var module: any Module {
    return MeModule.me
  }
  
  static func initViewControllerWith(parameter:Any?) -> UIViewController {
    let vc = UIStoryboard(name: "MeViewController", bundle: nil).instantiateViewController(withIdentifier: "MeViewController") as! MeViewController
    vc.viewModel = MeViewModel(parameter: parameter)
    return vc
  }
  
  
}
