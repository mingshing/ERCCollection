//
//  CollectionItemViewModel.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import Foundation
import RxSwift

struct CollectionItemViewModel: Equatable {
    
    let contractName: String
    let name: String
    let description: String
    let imageUrl: URL
    
    init(_ item: CollectionItem) {
        self.contractName = item.contractName
        self.name = item.name
        self.description = item.description
        self.imageUrl = URL(string: item.imageUrl)!
    }
}
