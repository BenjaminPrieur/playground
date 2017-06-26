//: [Previous](@previous)

import Foundation

extension String {
	func formatted(withOptions options: Set<Post.TextFormatter.Option>) -> String {
		return self
	}
}

struct Post {

	let id: Int
	let author: String
	let title: String
	let text: String

	// *********************************************************************
	// MARK: - TextFormatter

	class TextFormatter {
		private let options: Set<Option>

		init(options: Set<Option>) {
			self.options = options
		}

		func formatTitle(for post: Post) -> String {
			return post.title.formatted(withOptions: options)
		}

		func formatText(for post: Post) -> String {
			return post.text.formatted(withOptions: options)
		}

		// *********************************************************************
		// MARK: - Options

		enum Option {
			case highlightNames
			case highlightLinks
		}
	}
}

let post = Post(id: 1, author: "John", title: "Alice au pays des merveilles", text: "Il etait une fois...")
let formatter = Post.TextFormatter(options: [.highlightNames])
let text = formatter.formatText(for: post)

//: [Next](@next)
