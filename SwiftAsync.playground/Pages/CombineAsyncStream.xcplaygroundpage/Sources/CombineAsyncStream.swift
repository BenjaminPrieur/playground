import Foundation
import Combine

public class CombineAsyncStream<Upstream: Publisher>: AsyncSequence {
  public typealias Element = Upstream.Output
  public typealias AsyncIterator = CombineAsyncStream<Upstream>

  public func makeAsyncIterator() -> Self {
    return self
  }

  private let stream:
  AsyncThrowingStream<Upstream.Output, Error>

  private lazy var iterator = stream.makeAsyncIterator()

  private var cancellable: AnyCancellable?
  public init(_ upstream: Upstream) {
    var subscription: AnyCancellable? = nil

    stream = AsyncThrowingStream<Upstream.Output, Error>(Upstream.Output.self) { continuation in
      subscription = upstream
        .handleEvents(
          receiveCancel: {
            continuation.finish(throwing: nil)
          }
        )
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            continuation.finish(throwing: error)
          case .finished: continuation.finish(throwing: nil)
          }
        }, receiveValue: { value in
          continuation.yield(value)
        })
    }

    cancellable = subscription
  }

  public func cancel() {
    cancellable?.cancel()
    cancellable = nil
  }
}

extension CombineAsyncStream: AsyncIteratorProtocol {
  public func next() async throws -> Upstream.Output? {
    return try await iterator.next()
  }
}

public extension Publisher {
  func asyncStream() -> CombineAsyncStream<Self> {
    return CombineAsyncStream(self)
  }
}
