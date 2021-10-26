//
//  CodableObject.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct CodableObject: View {
    @State private var newSettings = Settings()
    @State private var fullName = ""
    @FocusState var focusedField: Bool?
    @Binding var receiveNotification: Bool
    var body: some View {
            VStack {
                HStack {
                    Text(fullName).padding(7)
                        .frame(width: 125)
                        .overlay(RoundedRectangle(cornerRadius: 5,style: .continuous).stroke(Color(.secondarySystemBackground)))
                    Button {
                        // Load stored settings
                        fullName = NSUbiquitousKeyValueStore.settings.fullName
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
                    NSUbiquitousKeyValueStore.settings = newSettings
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
            .navigationTitle("Codable Object")
            .dismissToolbarButton(focusedField: _focusedField)
            .onChange(of: receiveNotification) { newValue in
                if newValue {
                    fullName = NSUbiquitousKeyValueStore.settings.fullName
                    receiveNotification = false
                }
            }
            .onAppear {
                fullName = NSUbiquitousKeyValueStore.settings.fullName
            }
    }
}

struct CodableObject_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CodableObject(receiveNotification: .constant(false))
        }
        .navigationViewStyle(.stack)
    }
}
