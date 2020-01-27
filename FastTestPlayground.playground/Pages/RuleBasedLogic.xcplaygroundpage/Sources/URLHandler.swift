import Foundation
import UIKit

public struct URLHandler {
    private let navigationController: UINavigationController
    private let rules: [String : [URLRule]]

    public init(navigationController: UINavigationController, rules: [URLRule]) {
        self.navigationController = navigationController
        self.rules = Dictionary(grouping: rules) { $0.requiredHost }
    }

    public func handle(_ url: URL) {
        guard url.scheme == "music-app",
              let host = url.host,
              let rules = rules[host] else {
            return
        }

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

            // As soon as we've encountered a rule that successfully
            // matches the given URL, we'll stop our iteration:
            navigationController.pushViewController(vc, animated: true)
            return
        }
    }
}
