import Foundation

public enum Result<T> {
	case success(T)
	case failure(Error)

	func decode<NewResult: Decodable>() -> NewResult? {

		switch self {

		case .success(let data as Data):
			return try? JSONDecoder().decode(NewResult.self, from: data)

		default:
			return nil

		}

	}
}
