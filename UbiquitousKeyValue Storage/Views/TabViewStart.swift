//
//  TabViewStart.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct TabViewStart: View {
    let pub = NotificationCenter.default.publisher(for: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        .receive(on: RunLoop.main)
    @State private var receiveNotification = false
    var body: some View {
        NavigationView {
            TabView {
                SimpleObject(receiveNotification: $receiveNotification)
                    .tabItem{
                        Label("Simple Object",systemImage: "1.circle.fill")
                    }
                CodableObject(receiveNotification: $receiveNotification)
                    .tabItem{
                        Label("Codable Object",systemImage: "2.circle.fill")
                    }
            }
        }
        .onReceive(pub, perform: { pub in
            if pub.name == NSUbiquitousKeyValueStore.didChangeExternallyNotification {
                receiveNotification = true
            }
        })
        .navigationViewStyle(.stack)
    }
}

struct TabViewStart_Previews: PreviewProvider {
    static var previews: some View {
        TabViewStart()
    }
}
