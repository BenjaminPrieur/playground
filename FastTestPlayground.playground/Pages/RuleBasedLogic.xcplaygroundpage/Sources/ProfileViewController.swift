import Foundation
import UIKit

public class ProfileViewController: UIViewController {

    var username: String

    public init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

public extension URLRule {
    static var profile: URLRule {
        return URLRule(
            requiredHost: "profile",
            requiresPathComponents: true,
            evaluate: { input in
                return ProfileViewController(
                    username: input.pathComponents[0]
                )
        }
        )
    }
}
