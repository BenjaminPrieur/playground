import Foundation

public enum JSON {
	case intValue(Int)
	case stringValue(String)
	case arrayValue(Array<JSON>)
	case dictionaryValue(Dictionary<String, JSON>)

	public var stringValue: String? {
		if case .stringValue(let str) = self {
			return str
		}
		return nil
	}

	public subscript(index: Int) -> JSON? {
		if case .arrayValue(let arr) = self {
			return index < arr.count ? arr[index] : nil
		}
		return nil
	}

	public subscript(key: String) -> JSON? {
		if case .dictionaryValue(let dict) = self {
			return dict[key]
		}
		return nil
	}
}
