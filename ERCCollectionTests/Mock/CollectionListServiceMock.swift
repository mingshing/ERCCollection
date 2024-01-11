//
//  CollectionListServiceMock.swift
//  ERCCollectionTests
//
//  Created by mingshing on 2024/1/11.
//
import RxSwift
@testable import ERCCollection

enum CollectionServiceMockType {
    case hasNextPage
    case noNextPage
    case error
}

class CollectionListServiceMock: CollectionListServiceType {
    let mockType: CollectionServiceMockType
    init(_ type: CollectionServiceMockType = .hasNextPage) {
        self.mockType = type
    }
    func getCollectionList(_ queryParam: CollectionListQueryParameter) -> Single<([CollectionItem], String?)> {
        switch mockType {
        case .hasNextPage:
            return .just((MockData.collectionItemList, MockData.pageKey))
        case .noNextPage:
            return .just((MockData.collectionItemList, nil))
        case .error:
            return .error(MockError.someError)
        }
    }
}
