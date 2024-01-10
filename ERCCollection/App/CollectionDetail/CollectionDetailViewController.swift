//
//  CollectionDetailViewController.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import RxSwift
import RxCocoa

class CollectionDetailViewController: UIViewController, StoryboardInitializable {
    
    private let disposeBag = DisposeBag()
    var viewModel: CollectionDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        self.title = "Detail page"
    }
    
    private func setupBindings() {
        
    }
}
