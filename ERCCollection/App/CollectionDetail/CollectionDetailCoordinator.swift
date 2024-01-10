//
//  CollectionDetailCoordinator.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import RxSwift
import SafariServices

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
        viewModel.openPermalink
                    .subscribe(
                        onNext: { [weak self] in
                            guard let self  = self else { return }
                            self.openPermalink(in: navigationController)
                    })
                    .disposed(by: disposeBag)
        navigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
    private func openPermalink(in navigationController: UINavigationController) {
        if let url = URL(string: "https://testnets.opensea.io/assets/goerli/") {
            let safariViewController = SFSafariViewController(url: url)
            navigationController.pushViewController(safariViewController, animated: true)
        }
    }
}
