import Foundation

public class Operation: Foundation.Operation {

	var state = State.loading

}

// *********************************************************************
// MARK: - Before

//public extension Operation {
//	enum State {
//		case loading
//		case failed(Error)
//		case finished
//	}
//}

// *********************************************************************
// MARK: - After

extension Operation {
	enum State {
		case loading
		case finished(Outcome)
	}

	enum Outcome {
		case failed(Error)
		case succeeded
	}
}

