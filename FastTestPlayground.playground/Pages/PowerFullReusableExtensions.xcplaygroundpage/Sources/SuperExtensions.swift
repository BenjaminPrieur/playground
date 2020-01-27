import Foundation

public extension Encodable where Self: Identifiable {
    // We also take this opportunity to parameterize our JSON
    // encoder, to enable the users of our new API to pass in
    // a custom encoder, and to make our method's dependencies
    // more clear:
    func cacheOnDisk(using encoder: JSONEncoder = .init()) throws {
        let folderURLs = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )

        // Rather than hard-coding a specific type's name here,
        // we instead dynamically resolve a description of the
        // type that our method is currently being called on:
        let typeName = String(describing: Self.self)
        let fileName = "\(typeName)-\(id).cache"
        let fileURL = folderURLs[0].appendingPathComponent(fileName)
        let data = try encoder.encode(self)
        try data.write(to: fileURL)
    }
}

extension Result where Success: RangeReplaceableCollection {
    func combine(with other: Self) throws -> Self {
        try .success(get() + other.get())
    }
}

// *********************************************************************
// MARK: - ConvertData
public protocol ContainerDataConvertible {
    static func makeContainerData(for value: Self) throws -> Data
}

extension Data: ContainerDataConvertible {
    public static func makeContainerData(for value: Data) -> Data {
        value
    }
}

extension String: ContainerDataConvertible {
    public static func makeContainerData(for value: String) -> Data {
        Data(value.utf8)
    }
}

//extension UIImage: ContainerDataConvertible {
//    public static func makeContainerData(for value: UIImage) throws -> Data {
//        guard let data = value.pngData() else {
//            throw Container.Error.failedToConvertImageToPNGData
//        }
//
//        return data
//    }
//}

public struct Container {
    public init() {}

    public func write<T: ContainerDataConvertible>(_ value: T) throws {
        let data = try T.makeContainerData(for: value)
    }
}
