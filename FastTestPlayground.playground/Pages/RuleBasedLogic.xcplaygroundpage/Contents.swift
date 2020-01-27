//: [Previous](@previous)

import Foundation
import UIKit

struct SearchResultsLoaderMock: SearchResultsLoader {}
let searchResultsLoader = SearchResultsLoaderMock()

let rules: [URLRule] = [
    .profile,
    .search(using: searchResultsLoader)
]


let url = URL(string: "music-app://profile/benp")!
let host = url.host!
let input = URLRule.Input(url: url)

for rule in rules where rule.requiredHost == host {
    if rule.requiresPathComponents {
        guard !input.pathComponents.isEmpty else {
            continue
        }
    }

    guard let vc = try? rule.evaluate(input) else {
        continue
    }

    print(vc)
}

let urlHandler = URLHandler(navigationController: UINavigationController(), rules: rules)

//: [Next](@next)
