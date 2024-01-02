//
//  AppCoordinator.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/2.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let collectionListCoordinator = CollectionListCoordinator(window: window)
        return coordinate(to: collectionListCoordinator)
    }
}
