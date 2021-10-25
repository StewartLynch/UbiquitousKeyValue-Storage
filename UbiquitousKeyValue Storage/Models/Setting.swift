//
//  Setting.swift
//  UbiquitousKeyValue Storage
//
//  Created by Stewart Lynch on 2021-10-24.
//

import Foundation

struct Settings: Codable {
    var firstName: String = ""
    var lastName: String = ""
    
    var fullName: String {
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
}
