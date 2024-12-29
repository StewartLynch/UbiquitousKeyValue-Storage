//
//  UbiquitousKeyValue_StorageApp.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

@main
struct UbiquitousKeyValue_StorageApp: App {
    @State private var storeObserver = KeyValueStoreObserver()
    var body: some Scene {
        WindowGroup {
            TabViewStart()
                .environment(storeObserver)
        }
    }
}
