//
//  CollectionListServiceMock.swift
//  ERCCollectionTests
//
//  Created by mingshing on 2024/1/11.
//
import RxSwift
@testable import ERCCollection

class CollectionListServiceMock: CollectionListServiceType {
    func getCollectionList(_ queryParam: CollectionListQueryParameter) -> Observable<([CollectionItem], String?)> {
        let itemList = MockData.collectionItemList
        let queryPageKey = MockData.pageKey
        return Observable.just((itemList, queryPageKey))
    }
}
