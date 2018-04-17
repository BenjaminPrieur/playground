import Foundation

public enum ImageCacheError {
	case emptyKey
	case dataConversionFailed
}

// When using throwing tests, making your errors conform to
// LocalizedError will render a much nicer error message in
// Xcode (per default only the error code is shown).
extension ImageCacheError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .emptyKey:
			return "An empty key was given"
		case .dataConversionFailed:
			return "Failed to convert the given image to Data"
		}
	}
}
