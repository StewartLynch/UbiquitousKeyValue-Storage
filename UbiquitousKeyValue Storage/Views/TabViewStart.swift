//
//  TabViewStart.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct TabViewStart: View {
    
    var body: some View {
        NavigationView {
            TabView {
                SimpleObject()
                    .tabItem{
                        Label("Simple Object",systemImage: "1.circle.fill")
                    }
                CodableObject()
                    .tabItem{
                        Label("Codable Object",systemImage: "2.circle.fill")
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct TabViewStart_Previews: PreviewProvider {
    static var previews: some View {
        TabViewStart()
    }
}
