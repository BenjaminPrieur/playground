import Foundation
import UIKit

public protocol SearchResultsLoader {}

class SearchViewController: UIViewController {
    init(loader: SearchResultsLoader, query: String?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension URLRule {
    static func search(using loader: SearchResultsLoader) -> URLRule {
        return URLRule(
            requiredHost: "search",
            requiresPathComponents: false,
            evaluate: { input in
//                guard let query = input.valueForQueryItem(named: "q") else {
//                    throw MismatchError()
//                }
                let query = input.valueForQueryItem(named: "q")

                return SearchViewController(
                    loader: loader,
                    query: query
                )
            }
        )
    }
}
