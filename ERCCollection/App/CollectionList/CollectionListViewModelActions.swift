//
//  CollectionListViewModelActions.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import Foundation
import RxCocoa

protocol CollectionListViewModelActions: AnyObject {
    func fetchCollections(
        currentPage: String?
    )
    
    var collectionList : BehaviorRelay<[CollectionItemViewModel]> { get }
    var scrollEnded : PublishRelay<Void> { get }
}
