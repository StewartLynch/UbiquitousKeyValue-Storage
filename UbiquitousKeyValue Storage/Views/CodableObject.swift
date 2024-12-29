//
//  CodableObject.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct CodableObject: View {
    @Environment(KeyValueStoreObserver.self) var storeObserver
    @State private var newSettings = Settings()
    
    @FocusState var focusedField: Bool?
    var body: some View {
        VStack {
            HStack {
                Text(storeObserver.settings.fullName).padding(7)
                    .frame(width: 125)
                    .overlay(RoundedRectangle(cornerRadius: 5,style: .continuous).stroke(Color(.secondarySystemBackground)))
                Button {
                    storeObserver.loadStoreSettings()
                } label: {
                    Text("Retrieve Settings")
                }
                .buttonStyle(.borderedProminent)
            }
            Group {
                TextField("First Name", text: $newSettings.firstName)
                    .focused($focusedField,equals: true)
                TextField("Last Name", text: $newSettings.lastName)
                    .focused($focusedField,equals: true)
            }
            .textFieldStyle(.roundedBorder)
            Button {
                // Save updated settings
                storeObserver.updateStoreSetting(newSettings)
                newSettings = Settings()
                focusedField = nil
            } label: {
                Text("Save")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .frame(width: 300)
        .padding(.vertical)
        .onAppear {
            storeObserver.loadStoreSettings()
        }
    }
}

#Preview {
    CodableObject()
        .environment(KeyValueStoreObserver())
}

