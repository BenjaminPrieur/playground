//: [Previous](@previous)

import Foundation
import SwiftUI

enum FetchError: Error {
  case invliadServerResponse
  case invalidImage
}

func fetch(url: URL) async throws -> Image {
  let (data, response) = try await URLSession.shared.data(from: url)

  guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    throw FetchError.invliadServerResponse
  }

  guard let image = UIImage(data: data) else {
    throw FetchError.invalidImage
  }

  return Image(uiImage: image)
}

Task {
  do {
    let image = try await fetch(
      url: URL(string: "https://assets.sorare.com/card/6a2387a5-d8c7-4427-bc45-dc6d43cc14c6/picture/6514bbd4151f2bc1e1a280f6a358b356")!
    )
    print(image)
  } catch let err {
    print("Error: \(err)")
  }
}

//: [Next](@next)
