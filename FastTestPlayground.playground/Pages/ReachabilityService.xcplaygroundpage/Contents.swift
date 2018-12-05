//: [Previous](@previous)

import Foundation

public enum ReachabilityStatus {
    case reachable(viaWiFi: Bool)
    case unreachable
}

extension ReachabilityStatus {
    var reachable: Bool {
        switch self {
        case .reachable:
            return true
        case .unreachable:
            return false
        }
    }
}

protocol ReachabilityService {
    var reachabilityStatus: ReachabilityStatus { get }
}

enum ReachabilityServiceError: Error {
    case failedToCreate
}

class DefaultReachabilityService: ReachabilityService {
    private var _reachabilitySubject: ReachabilityStatus
    var reachabilityStatus: ReachabilityStatus {
        return _reachabilitySubject
    }

    let _reachability: Reachability

    init() throws {
        guard let reachabilityRef = Reachability() else { throw ReachabilityServiceError.failedToCreate }
        var reachabilitySubject = ReachabilityStatus.unreachable

        // so main thread isn't blocked when reachability via WiFi is checked
        let backgroundQueue = DispatchQueue(label: "reachability.wificheck")

        reachabilityRef.whenReachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject = .reachable(viaWiFi: reachabilityRef.isReachableViaWiFi)
            }
        }

        reachabilityRef.whenUnreachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject = .unreachable
            }
        }

        try reachabilityRef.startNotifier()
        _reachability = reachabilityRef
        _reachabilitySubject = reachabilitySubject
    }

    deinit {
        _reachability.stopNotifier()
    }
}

//extension ObservableConvertibleType {
//    func retryOnBecomesReachable(_ valueOnFailure:E, reachabilityService: ReachabilityService) -> Observable<E> {
//        return self.asObservable()
//            .catchError { (e) -> Observable<E> in
//                reachabilityService.reachability
//                    .skip(1)
//                    .filter { $0.reachable }
//                    .flatMap { _ in
//                        Observable.error(e)
//                    }
//                    .startWith(valueOnFailure)
//            }
//            .retry()
//    }
//}

try DefaultReachabilityService()

//: [Next](@next)
