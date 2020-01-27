import Foundation

public struct User: Identifiable, Encodable {
    public let id: ID
    public let name: String

    public init(id: RawIdentifier, name: String) {
        self.id = Identifier(rawValue: id)
        self.name = name
    }
}

public struct Category: Identifiable {
    public typealias RawIdentifier = Int

    public let id: ID
}
