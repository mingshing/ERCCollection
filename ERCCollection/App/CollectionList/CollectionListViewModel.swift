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
    let showLoading = BehaviorRelay<Bool>(value: true)
    
    private var currentPageKey: String? = nil
    
    let selectCollection: AnyObserver<CollectionItemViewModel>
    let showCollection: Observable<CollectionItemViewModel>
    
    private let collectionListService: CollectionListServiceType
    private let disposeBag = DisposeBag()
    
    init(collectionListService: CollectionListServiceType = CollectionListService()) {
        self.collectionListService = collectionListService
        let _selectCollection = PublishSubject<CollectionItemViewModel>()
        self.selectCollection = _selectCollection.asObserver()
        self.showCollection = _selectCollection.asObservable()
        self.fetchCollections()
        bindScrollEnded()
    }
}
extension CollectionListViewModel {
    func fetchCollections() {
        var queryParam: CollectionListQueryParameter
        if let pageKey = self.currentPageKey {
            queryParam = .nextPage(pageKey)
        } else {
            queryParam = .firstPage
        }
        showLoading.accept(true)
        self.collectionListService.getCollectionList(queryParam)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (collectionItems, pageKey) in
                guard let self = self else { return }
                self.showLoading.accept(false)
                self.currentPageKey = pageKey
                
                let existData = self.collectionList.value
                let itemViewModels = collectionItems.map { CollectionItemViewModel($0) }
                if existData.isEmpty {
                    self.collectionList.accept(itemViewModels)
                } else {
                    self.collectionList.accept(existData + itemViewModels)
                }
            }, onFailure: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    private func bindScrollEnded() {
        scrollEnded
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                if self.currentPageKey != nil {
                    self.fetchCollections()
                }
            }
            .disposed(by: disposeBag)
    }
}
