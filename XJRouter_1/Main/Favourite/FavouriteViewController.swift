//
//  FavouriteViewController.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import UIKit

class FavouriteViewController: UIViewController,MVVMViewProtocol {

  var viewModel:FavouriteViewModel!
  

  

    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "Favourite"
      viewModel = FavouriteViewModel()
      let vcs = self.navigationController?.viewControllers
      vcs?.forEach({ vcs in
        print("favourite vcs is \(vcs)")
      })
        // Do any additional setup after loading the view.
    }
    
  @IBAction func poptoMe(_ sender: Any) {
    dispatch(FavouriteViewModelInputEvent.backToMe)
  }
  
  @IBAction func poptoHome(_ sender: Any) {
    dispatch(FavouriteViewModelInputEvent.backtoHome)
  }
  
}
extension FavouriteViewController:ViewControllerCoordinator{
  static var module: any Module {
    return FavouriteModule.favourite
  }
  
  static func initViewControllerWith(parameter:Any?) -> UIViewController {
    let vc =  UIStoryboard(name: "FavouriteViewController", bundle: nil).instantiateViewController(withIdentifier: "FavouriteViewController") as! FavouriteViewController
    vc.viewModel = FavouriteViewModel()
    return vc
  }
  
  
}
