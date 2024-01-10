//
//  CollectionDetailCoordinator.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import RxSwift

class CollectionDetailCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = CollectionDetailViewModel()
        let viewController = CollectionDetailViewController.initFromStoryboard(name: "Main")
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
}
