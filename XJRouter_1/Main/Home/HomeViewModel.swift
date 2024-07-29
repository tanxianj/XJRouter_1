//
//  HomeViewModel.swift
//  XJRouter_1
//
//  Created by Jupiter_TSS on 5/2/24.
//

import Foundation
import RxSwift
import RxCocoa
enum HomeViewModelInputEvent:InputEvent{
  case back
  case gotoMe
}
class HomeViewModel:MVVMVMProtocol{
  
  typealias Coordinator = HomeCoordinator
  
  //weak var coordinator:Coordinator! = HomeCoordinator.sharedInstance()
  lazy var coordinator:Coordinator = {
    return HomeCoordinator.sharedInstance()
  }()
 
  init(){
    
  }
  
  typealias Outputs = (
  
  )
  
  func callAsFunction() -> () {
    
    
  }
  
  
  func handleEvent(event: InputEvent) {
    if let event = event as? HomeViewModelInputEvent{
      switch event {
        case .back:
          //printList() 
          break
        case .gotoMe:
          print("me")
//          coordinator.events.onNext(.pushToCoordinator(MeCoordinator.sharedInstance()))
          coordinator.events.onNext(.pushToModule(module: MeModule.me,parameter: "Home to Me"))
      }
    }
  }
  
  
}
extension HomeViewModel{
  func printList(){
    let totalCount : Int = 1000
    var items : [SelfCareAdviceServicesItem] = []
    let allInstitution = HospitalIconType.allCases
    let referenceDates = ["2023-08-23T12:12:12.012345",
                          "2023-07-24T12:12:12.012345",
                          "2023-06-25T12:12:12.012345",
                          "2023-05-26T12:12:12.012345"]
    
    for i in 0..<totalCount {
      let index = Int.random(in: 0..<allInstitution.count)
      let referenceDateIndex = Int.random(in: 0..<referenceDates.count)
      let model = SelfCareAdviceServicesItem(educationMaterialId: "\(i)",
                                             id: "\(i)",
                                             institution: allInstitution[index].rawValue,
                                             lastOrderDate: "2023-08-22T12:12:12.012345",
                                             lastReadTime:  i % 2 == 0 ? nil :"2023-08-22T12:12:12.012345",
                                             referenceCode: "7720064411G0001",
                                             referenceDate: referenceDates[referenceDateIndex],
                                             sequence: i,
                                             specialtyCode: "BR",
                                             specialtyName: "Breast",
                                             title: "Stereotactic Biopsy - \(i)",
                                             type: i % 2 == 0 ? 0 : 1,
                                             url: "https://www.baidu.com")
      
      items.append(model)
    }
    
    
    let servicesModel = SelfCareAdviceServicesModel(items: items, totalCount: totalCount)
    
    if let data = try? JSONEncoder().encode(servicesModel),let str = String(data: data, encoding: .utf8){
      print("Str is \(str)")
    }
  }
}
enum HospitalIconType:String,CaseIterable{
  case SGH
  case CGH
  case SKH
  case KKH
  case NCCS
  case NDCS
  case NHCS
  case NNI
  case SNEC
  case SCH
  case SHP
}
struct SelfCareAdviceServicesModel : Decodable,Encodable {

  let items : [SelfCareAdviceServicesItem]?
  let totalCount : Int?


}

struct SelfCareAdviceServicesItem : Decodable,Encodable {

  let educationMaterialId : String?
  let id : String?
  let institution : String?
  let lastOrderDate : String?
  let lastReadTime : String?
  let referenceCode : String?
  let referenceDate : String?
  let sequence : Int?
  let specialtyCode : String?
  let specialtyName : String?
  let title : String?
  let type : Int?
  let url : String?

  init(educationMaterialId: String?, id: String?, institution: String?, lastOrderDate: String?, lastReadTime: String?, referenceCode: String?, referenceDate: String?, sequence: Int?, specialtyCode: String?, specialtyName: String?, title: String?, type: Int?, url: String?) {
    self.educationMaterialId = educationMaterialId
    self.id = id
    self.institution = institution
    self.lastOrderDate = lastOrderDate
    self.lastReadTime = lastReadTime
    self.referenceCode = referenceCode
    self.referenceDate = referenceDate
    self.sequence = sequence
    self.specialtyCode = specialtyCode
    self.specialtyName = specialtyName
    self.title = title
    self.type = type
    self.url = url
  }


}
