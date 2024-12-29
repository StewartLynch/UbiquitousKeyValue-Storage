//
//----------------------------------------------
// Original project: UbiquitousKeyValue Storage
// by  Stewart Lynch on 2024-12-29
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2024 CreaTECH Solutions. All rights reserved.

import Foundation

@Observable
class KeyValueStoreObserver {
    private let store = NSUbiquitousKeyValueStore()
    var value = ""
    var settings = Settings()
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyValueStoreChange(_:)),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: store
        )
        store.synchronize()
    }

    @objc private func handleKeyValueStoreChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        if let reason = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int {
            switch reason {
            case NSUbiquitousKeyValueStoreServerChange:
                print("Changes came from iCloud.")
            case NSUbiquitousKeyValueStoreInitialSyncChange:
                print("Initial sync with iCloud completed.")
            case NSUbiquitousKeyValueStoreQuotaViolationChange:
                print("Quota violation occurred.")
            default:
                break
            }
        }

        if let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] {
            print("Changed keys: \(changedKeys)")
            for key in changedKeys {
               
                if let newValue = store.object(forKey: key) {
                    print("Key: \(key), New Value: \(newValue)")
                    if key == Key.value.rawValue {
                        loadStoreValue()
                        print("The new value property: \(value)")
                        
                    } else {
                        loadStoreSettings()
                        print("New name: \(settings.fullName)")
                    }
                }
            }
        }
        
    }

    func updateStoreValue(_ value: String) {
        NSUbiquitousKeyValueStore.value = value
    }
    
    func loadStoreValue() {
        value = NSUbiquitousKeyValueStore.value
    }

    func updateStoreSetting(_ settings: Settings) {
        NSUbiquitousKeyValueStore.settings = settings
    }
    
    func loadStoreSettings() {
        settings = NSUbiquitousKeyValueStore.settings
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
