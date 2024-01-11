//
//  MockDataManager.swift
//  ERCCollectionTests
//
//  Created by mingshing on 2024/1/11.
//

@testable import ERCCollection

enum MockError: Error {
    case someError
}

struct MockData {
    static let collectionItemList: [CollectionItem] = [
        collectionItem,
        collectionItem
    ]
    static var collectionItemViewModels: [CollectionItemViewModel] = collectionItemList.map { CollectionItemViewModel($0) }
    
    static var collectionItem: CollectionItem = CollectionItem(
        contract: Contract(name: "Testing ContractName"),
        name: "Testing item name",
        description: "Testing description",
        image: ImageURL(originalURL: "image origin URL")
    )
    
    static var collectionItemViewModel: CollectionItemViewModel = CollectionItemViewModel(collectionItem)
    
    static let pageKey: String = "mockPageKey"
}
