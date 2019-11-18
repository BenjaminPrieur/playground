import Foundation

public struct ListItem {

    public static var empty: ListItem {
        return ListItem()
    }

}

public struct ListItemParser {
    public enum Kind {
        case numbered
        case unordered
    }

    let kind: Kind

    public init(kind: Kind) {
        self.kind = kind
    }

    public func parseLine(_ line: String) throws -> ListItem {
        // Here we're switching on an optional Character, which is
        // the type of values that Swift strings are made up of:
        switch line.first {
        case .none:
            throw Error.emptyLine
        case \.isNewline:
            return .empty
        case \.isNumber where kind == .numbered:
            return parseLineAsNumberedItem(line)
        case "-" where kind == .unordered:
            return parseLineAsUnorderedItem(line)
        case .some(let character):
            throw Error.invalidFirstCharacter(character)
        }
    }

    func parseLineAsNumberedItem(_ line: String) -> ListItem {
        return .empty
    }

    func parseLineAsUnorderedItem(_ line: String) -> ListItem {
        return .empty
    }
}

public extension ListItemParser {
    enum Error: Swift.Error {
        case emptyLine
        case invalidFirstCharacter(Character)
    }
}
