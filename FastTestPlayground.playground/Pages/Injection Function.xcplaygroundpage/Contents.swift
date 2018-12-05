//: [Previous](@previous)

import Foundation

enum Setting {
    case profileIsPublic
}

class SettingsManager {
    private var settings: [Setting: Bool]
    private var syncing: (Setting, Bool) -> Void

    init(settings: [Setting: Bool], syncing: @escaping (Setting, Bool) -> Void) {
        self.settings = settings
        self.syncing = syncing
    }

    func enable(_ setting: Setting) {
        settings[setting] = true
        syncing(setting, true)
    }

    func disable(_ setting: Setting) {
        settings[setting] = false
        syncing(setting, false)
    }
}


// *********************************************************************
// MARK: - Test
var settings = [Setting: Bool]()
let syncing = { settings[$0] = $1 }

let manager = SettingsManager(
    settings: [:],
    syncing: syncing
)

manager.enable(.profileIsPublic)
settings == [.profileIsPublic: true]
print(settings)

//: [Next](@next)
