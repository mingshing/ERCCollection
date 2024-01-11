//
//  CollectionDetailViewModelTests.swift
//  ERCCollectionTests
//
//  Created by mingshing on 2024/1/11.
//

import XCTest
import RxSwift
import RxTest
@testable import ERCCollection

final class CollectionDetailViewModelTests: XCTestCase {

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
    
    func testTapPermalinkBtn() {
        let sut = CollectionDetailViewModel(MockData.collectionItemViewModel)
        let observer = scheduler.createObserver(Void.self)
        
        sut.openPermalink
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        sut.tapPermalink.onNext(())
        XCTAssertEqual(observer.events.count, 1, "we should got one tap event in observer")
    }
}
