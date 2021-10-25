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
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(fullName).padding(7)
                        .frame(width: 125)
                        .overlay(RoundedRectangle(cornerRadius: 5,style: .continuous).stroke(Color(.secondarySystemBackground)))
                    Button {
                        // Load stored settingds
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
        }
        .navigationViewStyle(.stack)
    }
}

struct CodableObject_Previews: PreviewProvider {
    static var previews: some View {
        CodableObject()
    }
}
