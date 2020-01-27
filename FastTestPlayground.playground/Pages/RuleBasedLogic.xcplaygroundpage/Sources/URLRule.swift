import Foundation
import UIKit

public struct URLRule {
    /// The host name that the rule requires in order to be evaluated.
    public var requiredHost: String
    /// Whether the URL's path components array needs to be non-empty.
    public var requiresPathComponents: Bool
    /// The body of the rule, which takes a set of input, and either
    /// produces a view controller, or throws an error.
    public var evaluate: (Input) throws -> UIViewController
}

public extension URLRule {
    struct Input {
        public var url: URL
        public var pathComponents: [String]
        public var queryItems: [URLQueryItem]
    }

    struct MismatchError: Error {}
}

public extension URLRule.Input {
    init(url: URL) {
        // A URL's path components include slashes, which we're
        // not interested in, so we'll simply filter them out:
        let pathComponents = url.pathComponents.filter {
            $0 != "/"
        }

        let queryItems = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ).flatMap { $0.queryItems }

        self.init(url: url, pathComponents: pathComponents, queryItems: queryItems ?? [])
    }

    func valueForQueryItem(named name: String) -> String? {
        let item = queryItems.first { $0.name == name }
        return item?.value
    }
}

public extension URLRule {
//    static var artist: URLRule {
//        return URLRule(
//            requiredHost: "artist",
//            requiresPathComponents: true,
//            evaluate: { input in
//                let rawID = input.pathComponents[0]
//
//                guard let id = Artist.ID(rawID) else {
//                    throw MismatchError()
//                }
//
//                let songID = input.valueForQueryItem(named: "song")
//                                  .flatMap(Song.ID.init)
//
//                return ArtistViewController(
//                    artistID: id,
//                    highlightedSongID: songID
//                )
//            }
//        )
//    }
}
