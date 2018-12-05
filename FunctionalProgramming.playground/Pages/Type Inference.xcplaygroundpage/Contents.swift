//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
print(str)

struct Video {
    let url: URL
    let containsAds: Bool
    var comments: [String]
}

extension Video: Decodable {
    enum CodingKey: String, Swift.CodingKey {
        case url
        case containsAds = "contains_ads"
        case comments
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKey.self)
        url = try container.decode(forKey: .url)
        containsAds = try container.decode(forKey: .containsAds, default: false)
        comments = try container.decode(forKey: .comments, default: [])
    }
}

let data = Data()
let video = try? data.decoded() as Video
print(video)

//: [Next](@next)
