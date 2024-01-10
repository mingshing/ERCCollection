//
//  CollectionItem.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/3.
//

import Foundation

struct Contract: Codable {
    let name: String
}

struct ImageURL: Codable {
    let originalURL: String

    enum CodingKeys: String, CodingKey {
        case originalURL = "originalUrl"
    }
}

struct CollectionItem: Codable {
    let contract: Contract
    let name: String
    let description: String
    let image: ImageURL
    
    var contractName: String {
        contract.name
    }
    var imageUrl: String {
        image.originalURL
    }
}
