//
//  ContentView.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import SwiftUI

struct SimpleObject: View {
    @Environment(KeyValueStoreObserver.self) var storeObserver
    @State private var newValue = ""
    @FocusState var focusedField: Bool?
    var body: some View {
        VStack {
            VStack {
                Text(storeObserver.value)
                    .padding()
                TextField("Enter new Value",text: $newValue)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField,equals: true)
                ControlGroup {
                    Button {
                        // Store value
                        storeObserver.updateStoreValue(newValue)
                        newValue = ""
                        focusedField = nil
                    } label: {
                        Text("Save")
                    }
                    Button {
                        storeObserver.loadStoreValue()
                    } label: {
                        Text("Load")
                    }
                }
                Spacer()
            }
        }
        .frame(width: 300)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        .onAppear {
            storeObserver.loadStoreValue()
        }
    }
}

#Preview {
    SimpleObject()
        .environment(KeyValueStoreObserver())
}
