//
//  ContentView.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct SimpleObject: View {
    @State private var dataString = ""
    @State private var newValue = ""
    @FocusState var focusedField: Bool?
    var body: some View {
            VStack {
                VStack {
                    Text(dataString)
                        .padding()
                    TextField("Enter new Value",text: $newValue)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField,equals: true)
                    ControlGroup {
                        Button {
                            // Store value
                            newValue = ""
                            focusedField = nil
                        } label: {
                            Text("Save")
                        }
                        Button {
                            // Get Value
                        } label: {
                            Text("Load")
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 300)
            .navigationTitle("Simple Object")
            .dismissToolbarButton(focusedField: _focusedField)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleObject()
    }
}
