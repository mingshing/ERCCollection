//
//  CollectionListViewController.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/2.
//

import RxSwift
import RxCocoa

/// Shows a list of most starred repositories filtered by language.
class CollectionListViewController: UIViewController, StoryboardInitializable {

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        self.title = "test"
    }

    private func setupBindings() {

    }
}
