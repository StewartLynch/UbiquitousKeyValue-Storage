//
//  UbiquitousStore.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-25.
//

import Foundation

@propertyWrapper
struct UbiquitousStore<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = NSUbiquitousKeyValueStore().object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            NSUbiquitousKeyValueStore().set(data, forKey: key)
            NSUbiquitousKeyValueStore().synchronize()
        }
    }
}

extension NSUbiquitousKeyValueStore {
    @UbiquitousStore(key: "value", defaultValue: "") static var value: String
    @UbiquitousStore(key: "settings", defaultValue: Settings()) static var settings: Settings
}
