//
//  AppDelegate.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    UITableViewCell.appearance().selectionStyle = .none
    UIButton.appearance().adjustsImageWhenDisabled = false
    UIButton.appearance().adjustsImageWhenHighlighted = false
    
    registerPathMap(with: self)
    initUI()
    
    return true
}
func initUI() {
    var rootViewController:UIViewController = UIViewController()
    if self.window == nil {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }

    rootViewController = APPTabbarViewController()

    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()
    
}
  func registerPathMap(with appDelegate: UIApplicationDelegate) {
      var count: UInt32 = 0
      guard let image = class_getImageName(object_getClass(appDelegate)),
          let classes = objc_copyClassNamesForImage(image, &count) else {
              print("JMRouter registerPathMap failed!!!!!!!!!!!!!!!!!!")
              return
      }
      for i in 0 ..< Int(count) {
          if let clsName = String(cString: classes[i], encoding: .utf8)?.components(separatedBy: ".").last {
            print("clsName is \(clsName)")
            if let cls = clsName.toClass() as? ViewControllerCoordinator.Type {
                print("cls is \(cls.module)")
              ModuleManager.sharedInstance().updateWith(module: cls.module, vcName: cls.vcName())
              print("cls vcName is \(cls.vcName())")
              }
          }
      }
  }


}


extension String{
  func toClass() -> AnyClass? {
      if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
          
          let classStringName = "_TtC\(appName.count)\(appName)\(self.count)\(self)"
          let cls: AnyClass?  = NSClassFromString(classStringName)
          return cls
      }
      return nil;
  }
}
