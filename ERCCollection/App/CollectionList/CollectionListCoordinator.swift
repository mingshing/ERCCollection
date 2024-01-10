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
        viewModel.showCollection
                    .subscribe(onNext: { [weak self] in self?.showCollectionDetail(with: $0, on: navigationController) })
                    .disposed(by: disposeBag)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showCollectionDetail(with: CollectionItemViewModel, on navigationController: UINavigationController) -> Observable<Void> {
            let collectionDetailCoordinator = CollectionDetailCoordinator(navigationController: navigationController)
            return coordinate(to: collectionDetailCoordinator)
        }
}
