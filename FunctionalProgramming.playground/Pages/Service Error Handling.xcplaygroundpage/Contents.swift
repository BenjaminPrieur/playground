//: [Previous](@previous)

import Foundation
import UIKit

//mark: - Enum
enum Result<T> {
  case Success(T)
  case Failure(Error)
}

//mark: - Protocol
protocol GenericService {
  associatedtype DataType
  func get(completion: (Result<DataType>) -> Void)
}

extension GenericService {
  func get(completion: (Result<DataType>) -> Void) {
  }
}

//mark: - Model
struct Item {}

//mark: - Service
struct ItemService: GenericService {
  typealias DataType = [Item]
}

class DemoViewController: UIViewController {

  // *********************************************************************
  // MARK: - Properties
  var dataSource = [Item]() {
    didSet {
      print(dataSource)
    }
  }

  override func viewDidLoad() {
    getElement(fromService: ItemService())
  }

  func getElement<Service: GenericService>(fromService service: Service) where Service.DataType == [Item] {
    service.get() {[weak self] result in

      switch result {
      case .Success(let food):
        self?.dataSource = food
      case .Failure(let error):
        print(error)
      }
    }
  }
}


//mark: - TU
struct MockItemService: GenericService {
  typealias DataType = [Item]

  var getWasCalled = false
  var result = Result.Success([Item(), Item()])

  mutating func get(completion: (Result<DataType>) -> Void) {
    getWasCalled = true
    completion(result)
  }
}

class DemoViewControllerTests {
  func testGetElement() {
    let mockItemService = MockItemService()
    let demoVC = DemoViewController()

    print(mockItemService.getWasCalled == false)
    demoVC.getElement(fromService: mockItemService)
    print(mockItemService.getWasCalled == true)
    print(demoVC.dataSource.count > 0)
  }
}

//: [Next](@next)
