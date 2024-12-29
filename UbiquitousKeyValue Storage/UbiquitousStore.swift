//
//  UbiquitousStore.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-25.
//

import Foundation

enum Key: String {
    case value, settings
}

@propertyWrapper
struct UbiquitousStore<T: Codable> {
    private let key: Key
    private let defaultValue: T
    
    init(key: Key, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = NSUbiquitousKeyValueStore().object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            NSUbiquitousKeyValueStore().set(data, forKey: key.rawValue)
            NSUbiquitousKeyValueStore().synchronize()
        }
    }
}

extension NSUbiquitousKeyValueStore {
    @UbiquitousStore(key: Key.value, defaultValue: "") static var value: String
    @UbiquitousStore(key: Key.settings, defaultValue: Settings()) static var settings: Settings
}
