//
//  CollectionDetailViewModel.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import Foundation
class CollectionDetailViewModel {
    
    let contractName: String
    let name: String
    let description: String
    let imageUrl: URL
    
    init(_ itemViewModel: CollectionItemViewModel) {
        self.contractName = itemViewModel.contractName
        self.name = itemViewModel.name
        self.description = itemViewModel.description
        self.imageUrl = itemViewModel.imageUrl
    }
}
