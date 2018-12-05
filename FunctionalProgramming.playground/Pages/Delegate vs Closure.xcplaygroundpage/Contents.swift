//: [Previous](@previous)

import Foundation

// Delegate
class FileImporterDelegateImp: FileImporterDelegate {
    func fileImporter(_ importer: FileImporter, shouldImportFile file: File) -> Bool {
        return true
    }
    func fileImporter(_ importer: FileImporter, didAbortWithError error: Error) {}
    func fileImporterDidFinish(_ importer: FileImporter) {}
}

let importerThroughDelegate = FileImporter()
importerThroughDelegate.delegate = FileImporterDelegateImp()
// vs
// configuration
let importerThroughConfiguration = FileImporter(configuration: .importAll)

let arr = [1, 2, 3, 4, 5]
arr.filter { toto in
    return toto % 2 == 0
}

arr.filter(pair)

func pair(toto: Int) -> Bool {
    return toto % 2 == 0
}

print("Bonjour")

//: [Next](@next)
