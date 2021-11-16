//: [Previous](@previous)

import Foundation

struct Product {}
extension Product {
    struct Recommendations {
        var featured: [Product]
        var favorites: [Product]
        var latest: [Product]
    }
}

class ProductLoader {

    func loadFeatured() async throws -> [Product] {
        let t = TimeInterval.random(in: 0.25 ... 2.0)
        Thread.sleep(forTimeInterval: t)
        return [Product]()
    }

    func loadFavorites() async throws -> [Product] {
        let t = TimeInterval.random(in: 0.25 ... 2.0)
        Thread.sleep(forTimeInterval: t)
        return [Product]()
    }

    func loadLatest() async throws -> [Product] {
        let t = TimeInterval.random(in: 0.25 ... 2.0)
        Thread.sleep(forTimeInterval: t)
        return [Product]()
    }
}

extension ProductLoader {
    func loadRecommendations() async throws -> Product.Recommendations {

        // Dont't do that...
        // Queries are performed in sequence, one after the other.
//        let featured = try await loadFeatured()
//        let favorites = try await loadFavorites()
//        let latest = try await loadLatest()
//
//        return Product.Recommendations(
//            featured: featured,
//            favorites: favorites,
//            latest: latest
//        )

        // To perform queries concurrently:
        async let featured = loadFeatured()
        async let favorites = loadFavorites()
        async let latest = loadLatest()

        return try await Product.Recommendations(
            featured: featured,
            favorites: favorites,
            latest: latest
        )
    }
}



//: [Next](@next)
