//
//  CollectionDetailViewModel.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import Foundation
import RxSwift

class CollectionDetailViewModel {
    
    let contractName: String
    let name: String
    let description: String
    let imageUrl: URL
    let tapPermalink: AnyObserver<Void>
    let openPermalink: Observable<Void>
    
    init(_ itemViewModel: CollectionItemViewModel) {
        self.contractName = itemViewModel.contractName
        self.name = itemViewModel.name
        self.description = itemViewModel.description
        self.imageUrl = itemViewModel.imageUrl
        let _tapPermalink = PublishSubject<Void>()
        self.tapPermalink = _tapPermalink.asObserver()
        self.openPermalink = _tapPermalink.asObservable()
    }
}
