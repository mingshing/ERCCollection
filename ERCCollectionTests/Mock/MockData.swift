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
        CollectionItem(
            contract: Contract(name: "Testing ContractName"),
            name: "Testing item name",
            description: "Testing description",
            image: ImageURL(originalURL: "image origin URL")
        ),
        CollectionItem(
            contract: Contract(name: "Testing ContractName 2"),
            name: "Testing item name 2",
            description: "Testing description 2",
            image: ImageURL(originalURL: "image origin URL 2")
        )
    ]
    static var collectionItemViewModels: [CollectionItemViewModel] = collectionItemList.map { CollectionItemViewModel($0) }
    static let pageKey: String = "mockPageKey"
}
