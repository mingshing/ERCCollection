//
//  CollectionListViewModelTests.swift
//  ERCCollectionTests
//
//  Created by mingshing on 2024/1/11.
//

import XCTest
import RxSwift
import RxTest
@testable import ERCCollection

final class CollectionListViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        disposeBag = nil
        scheduler = nil
        try super.tearDownWithError()
    }
    
    func testInitialFetch() {
        let sut = CollectionListViewModel(collectionListService: CollectionListServiceMock())
        let collectionListObserver = scheduler.createObserver([CollectionItemViewModel].self)
        sut.collectionList
            .bind(to: collectionListObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        XCTAssertEqual(
            collectionListObserver.events,
            [
                .next(0, MockData.collectionItemViewModels)
            ]
        )
    }

}
