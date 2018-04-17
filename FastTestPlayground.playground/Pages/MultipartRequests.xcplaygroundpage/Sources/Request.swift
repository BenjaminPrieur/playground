import Foundation

public protocol  Request {

	associatedtype Response

	typealias Handler = (Result<Response>) -> Void

	func perform(then handle: @escaping Handler)

}

extension Dictionary: Request where Value: Request {
	public typealias Response = [Key : Value.Response]

	public func perform(then handler: @escaping Handler) {
		var responses = [Key: Value.Response]()
		let group = DispatchGroup()
		print("number of items into dictionnary: \(self.keys.count)")

		for (key, request) in self {
			group.enter()

				print("\(key) enter")
			request.perform { response in
				print("\(key) done")
				switch response {
				case .success(let value):
					print("We have a winner!!!")
					responses[key] = value
					group.leave()
				case .failure(let error):
					print("Somethings wrong")
					handler(.failure(error))
				}
			}
		}

		group.notify(queue: .main) {
			print("Everythings Ok")
			handler(.success(responses))
		}
	}
}

public struct ArticleRequest: Request {

	public typealias Response = [Article]

	let dataLoader: DataLoader
	let category: ArticleCategory

	public init(dataLoader: DataLoader, category: ArticleCategory) {
		self.dataLoader = dataLoader
		self.category = category
	}

	public func perform(then handler: @escaping Handler) {
		let endpoint = Endpoint.articles(category: category)

		dataLoader.load(from: endpoint) { result in
			// Here we decode a Result<Data> value to either
			// produce an error or an array of models.
			if let response: Response = result.decode() {
				print(response)
				handler(.success(response))
			} else {
				print("failure")
				handler(.failure(NSError()))
			}
		}
	}
}
