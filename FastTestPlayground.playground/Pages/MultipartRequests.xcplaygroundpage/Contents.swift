//: [Previous](@previous)

import Foundation
import PlaygroundSupport

let requests: [ArticleCategory: ArticleRequest] = [
	.sport: ArticleRequest(dataLoader: NetworkLoader(session: .shared), category: .sport),
	.news: ArticleRequest(dataLoader: NetworkLoader(session: .shared), category: .news)
]

var listArticles: [Article] = []

PlaygroundPage.current.needsIndefiniteExecution = true

requests.perform { result in
	print("Somethings happen")
	switch result {
	case .success(let articles):
		for (_, articles) in articles {
			listArticles.append(contentsOf: articles)
		}
		print(listArticles)
	default:
		print("Error")
	}
}

//: [Next](@next)
