//
//  Drug.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import Foundation

struct Drug: Codable {
    let id: Int
    let image: String
    let categories: [Category]
    let name: String
    let description: String
    let fields: [Field]
}

struct Category: Codable {
    let id: Int
    let icon: String
    let image: String
    let name: String
}

struct Field {
    let typesId: Int
    let type: String
    let name: String
    let value: String
    let image: String
}

struct DrugResponse: Codable {
    let drugs: [Drug]
}

extension Field: Codable {
    enum CodingKeys: String, CodingKey {
        case typesId = "types_id"
        case type
        case name
        case value
        case image
    }
}

