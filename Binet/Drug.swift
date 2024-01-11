//
//  Drug.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import Foundation

import Foundation

struct Drug: Codable {
    let id: Int
    let image: String
    let categories: Category
    let name: String
    let description: String
    let fields: [Field]

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case categories
        case name
        case description
        case fields
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let fieldsArray = try? container.decode([Field].self, forKey: .fields) {
            fields = fieldsArray
        } else {
            fields = []
        }

        id = try container.decode(Int.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
        categories = try container.decode(Category.self, forKey: .categories)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
    }
}

struct Category: Codable {
    let id: Int
    let icon: String
    let image: String
    let name: String
}

struct Field: Codable {
    let typesId: Int
    let type: String
    let name: String
    let value: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case typesId = "types_id"
        case type
        case name
        case value
        case image
    }
}
