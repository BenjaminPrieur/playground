//: [Previous](@previous)

import Foundation
import UIKit

// *********************************************************************
// MARK: - Delaying a cancellable task with DispatchWorkItem

class SearchViewController: UIViewController, UISearchBarDelegate {
	// We keep track of the pending work item as a property
	private var pendingRequestWorkItem: DispatchWorkItem?

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		// Cancel the currently pending item
		pendingRequestWorkItem?.cancel()

		// Wrap our request in a work item
		let requestWorkItem = DispatchWorkItem { [weak self] in
//			self?.resultsLoader.loadResults(forQuery: searchText)
			print(searchText)
		}

		// Save the new work item and execute it after 250 ms
		pendingRequestWorkItem = requestWorkItem
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
		                              execute: requestWorkItem)
	}
}

// *********************************************************************
// MARK: - Grouping and chaining tasks with DispatchGroup

let group = DispatchGroup()

// NoteCollection is a thread-safe collection class for storing notes
let collection = NoteCollection()

// The 'enter' method increments the group's task count…
group.enter()
localDataSource.load { notes in
	collection.add(notes)
	// …while the 'leave' methods decrements it
	group.leave()
}

group.enter()
iCloudDataSource.load { notes in
	collection.add(notes)
	group.leave()
}

group.enter()
backendDataSource.load { notes in
	collection.add(notes)
	group.leave()
}

// This closure will be called when the group's task count reaches 0
group.notify(queue: .main) { [weak self] in
	self?.render(collection)
}

// *********************************************************************
// MARK: - Waiting for asynchronous tasks with DispatchSemaphore

// Like DispatchGroup, the semaphore API is very simple in that you only
// increment or decrement an internal counter, by either calling wait()
// or signal(). Calling wait() before a signal() will block the current
// queue until a signal is received.

let semaphore = DispatchSemaphore(value: 0)
var loadedCollection: NoteCollection?

// We create a new queue to do our work on, since calling wait() on
// the semaphore will cause it to block the current queue
let loadingQueue = DispatchQueue.global()

loadingQueue.async {
	// We extend 'load' to perform its work on a specific queue
	self.load(onQueue: loadingQueue) { collection in
		loadedCollection = collection

		// Once we're done, we signal the semaphore to unblock its queue
		semaphore.signal()
	}
}

// Wait with a timeout of 5 seconds
semaphore.wait(timeout: .now() + 5)

guard let collection = loadedCollection else {
	throw NoteLoadingError.timedOut
}

return collection

//: [Next](@next)
