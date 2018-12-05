//: [Previous](@previous)

import Foundation

// *********************************************************************
// MARK: - Tools
enum AdDetailType {
    case cost(title: String)
}

// *********************************************************************
// MARK: - Search
struct CostViewModel {
    var title: String
}

enum AdDetailVMType {
    case cost(viewModel: CostViewModel)
}

extension AdDetailType {
    func build() -> AdDetailVMType {
        switch self {
        case .cost(title: let title):
            CostViewModel.self
            return .cost(viewModel: CostViewModel(title: title))
        }
    }
}

let adType = AdDetailType.cost(title: "Coucou")
let viewModelType = adType.build()

switch (viewModelType) {
case .cost(viewModel: let viewModel):
    print(viewModel.title)
default:
    break
}

//: [Next](@next)
