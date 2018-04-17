import Foundation

public protocol DataLoader {
	func load(from: Endpoint, then handler: (Result<Data>) -> Void)
}

public class NetworkLoader: DataLoader {

	let session: URLSession

	public init(session: URLSession) {
		self.session = session
	}

	public func load(from: Endpoint, then handler: (Result<Data>) -> Void) {
		let json = """
[{
	"title": "article 1"
},
{
	"title": "article 1"
}]
""".data(using: .utf8)!
		handler(.success(json))
	}
}
