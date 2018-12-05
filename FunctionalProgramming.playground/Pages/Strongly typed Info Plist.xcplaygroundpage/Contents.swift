//: [Previous](@previous)

import Foundation

do {
    let appPList = try PListFile<InfoPList>(.infoPlist(Bundle(for: MyBundle.self)))
    // then read values
    let url = appPList.data.configuration.url // it’s an URL
} catch let err {
    print("Failed to parse data: \(err)")
}

//: [Next](@next)
