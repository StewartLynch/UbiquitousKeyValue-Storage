//
//  TabViewStart.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct TabViewStart: View {
    @FocusState var focusedField: Bool?
    @State private var selectedTab = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                Tab("Simple Object", systemImage: "1.circle.fill", value: 0) {
                    SimpleObject(focusedField: _focusedField)
                }
                Tab("Codable Object", systemImage: "2.circle.fill", value: 1) {
                    CodableObject(focusedField: _focusedField)
                }
            }
            .navigationTitle(selectedTab == 0 ? "Simple Object" :  "Codable Object")
        }
        
    }
}

#Preview {
    TabViewStart()
        .environment(KeyValueStoreObserver())
}
