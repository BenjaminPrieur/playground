import Foundation

public struct InfoPList: Codable {

    public struct Configuration: Codable {
        public let url: URL?
        public let environment: String
    }

    public let configuration: Configuration
}
