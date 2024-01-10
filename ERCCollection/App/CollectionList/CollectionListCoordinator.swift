//
//  CollectionListCoordinator.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/2.
//

import RxSwift

class CollectionListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = CollectionListViewModel()
        let viewController = CollectionListViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}
