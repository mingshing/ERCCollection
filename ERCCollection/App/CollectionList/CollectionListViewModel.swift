//
//  CollectionListViewModel.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/4.
//

import Foundation
import RxSwift
import RxRelay

class CollectionListViewModel: CollectionListViewModelActions {
    
    var collectionList = BehaviorRelay<[CollectionItemViewModel]>(value: [])
    var scrollEnded = PublishRelay<Void>()
    
    let selectCollection: AnyObserver<CollectionItemViewModel>
    let showCollection: Observable<CollectionItemViewModel>
    
    private let collectionListService: CollectionListService
    private let disposeBag = DisposeBag()
    
    init(collectionListService: CollectionListService = CollectionListService()) {
        self.collectionListService = collectionListService
        let _selectCollection = PublishSubject<CollectionItemViewModel>()
                self.selectCollection = _selectCollection.asObserver()
        self.showCollection = _selectCollection.asObservable()
        self.fetchCollections(currentPage: nil)
    }
}
extension CollectionListViewModel {
    func fetchCollections(currentPage: String?) {
        self.collectionListService.getCollectionList(.firstPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] collectionItems in
                let existData = self?.collectionList.value ?? []
                let itemViewModels = collectionItems.map { CollectionItemViewModel($0) }
                /// add new data to nil array
                if existData.isEmpty {
                    self?.collectionList.accept(itemViewModels)
                } else {
                    /// update exist data with adding new data
                    self?.collectionList.accept(existData + itemViewModels)
                }
            }) { error in
                print("Error: \(error)")
            }.disposed(by: disposeBag)
    }
}
