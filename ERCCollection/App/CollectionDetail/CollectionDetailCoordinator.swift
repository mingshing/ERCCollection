//
//  CollectionDetailCoordinator.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import RxSwift

class CollectionDetailCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    private let viewModel: CollectionDetailViewModel
    
    init(
        with viewModel: CollectionDetailViewModel,
        navigationController: UINavigationController
    ) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = CollectionDetailViewController.initFromStoryboard(name: "Main")
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
}
