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
    
    func testInitialFetchSuccess() {
        let sut = CollectionListViewModel(collectionListService: CollectionListServiceMock())
        let collectionListObserver = scheduler.createObserver([CollectionItemViewModel].self)
        let expectation = XCTestExpectation(description: "Fetching data")
        
        sut.collectionList
            .bind(to: collectionListObserver)
            .disposed(by: disposeBag)
        
        sut.collectionList
            .subscribe({ _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(
            collectionListObserver.events,
            [
                .next(0, MockData.collectionItemViewModels)
            ]
        )
    }
    
    func testScrollendFetchNextPageSuccess() {
        let sut = CollectionListViewModel(collectionListService: CollectionListServiceMock())
        let collectionListObserver = scheduler.createObserver([CollectionItemViewModel].self)
        let expectation = XCTestExpectation(description: "Fetching data")
        
        sut.collectionList
            .bind(to: collectionListObserver)
            .disposed(by: disposeBag)
        
        sut.collectionList
            .subscribe({ _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.scrollEnded)
            .disposed(by: disposeBag)
        
        scheduler.start()
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(
            collectionListObserver.events,
            [
                .next(0, MockData.collectionItemViewModels),
                .next(10, MockData.collectionItemViewModels + MockData.collectionItemViewModels)
            ],
            "When we scroll to end and have next page, we should get the collection list with two pages data"
        )
    }
    
    func testScrollendWithoutNextPage() {
        let sut = CollectionListViewModel(collectionListService: CollectionListServiceMock(.noNextPage))
        let collectionListObserver = scheduler.createObserver([CollectionItemViewModel].self)
        let expectation = XCTestExpectation(description: "Fetching data")
        
        sut.collectionList
            .bind(to: collectionListObserver)
            .disposed(by: disposeBag)
        
        sut.collectionList
            .subscribe({ _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.scrollEnded)
            .disposed(by: disposeBag)
        
        scheduler.start()
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(
            collectionListObserver.events,
            [
                .next(0, MockData.collectionItemViewModels)
            ],
            "When we scroll to end and without next page, we won't trigger fetch next page action"
        )
    }
}
