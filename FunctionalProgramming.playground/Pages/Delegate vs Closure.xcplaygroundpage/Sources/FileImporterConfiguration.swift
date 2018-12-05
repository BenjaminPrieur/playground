import Foundation

public struct FileImporterConfiguration {
    public var predicate: (File) -> Bool
    public var errorHandler: (Error) -> Void
    public var completionHandler: () -> Void
}

public extension FileImporterConfiguration {
    init(predicate: @escaping (File) -> Bool) {
        self.predicate = predicate
        errorHandler = { _ in }
        completionHandler = {}
    }

    static var importAll: FileImporterConfiguration {
        return .init { _ in true }
    }
}
