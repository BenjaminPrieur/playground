import Foundation

public extension Sequence {

	func sum<N: Numeric>(by valueProvider: (Element) -> N) -> N {
		return reduce(0) { result, element in
			return result + valueProvider(element)
		}
	}

}


public struct File {
	var data: Data
}

public extension Bundle {
	func loadFiles(named fileNames: [String]) throws -> [File] {
		return fileNames
			// Since flatMap returns a new sequence of all non-nil
			// values returned from its closure, it lets us automatically
			// skip all files that don't exist.
			.flatMap({ name in
				return url(forResource: name, withExtension: nil)
			})
			.map(Data.init)
			.map(File.init)
	}
}
