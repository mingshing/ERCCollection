//
//  CollectionDetailViewController.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import RxSwift
import RxCocoa
import Kingfisher

class CollectionDetailViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionItemName: UILabel!
    @IBOutlet weak var collectionItemDescription: UILabel!
    @IBOutlet weak var imageHeightAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var permaLinkBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: CollectionDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        
        self.title = viewModel.contractName
        self.collectionItemName.text = viewModel.name
        self.collectionItemDescription.text = viewModel.description
        
        collectionImage.kf.setImage(with: viewModel.imageUrl) { [weak self] result in
            guard let self = self else { return }
            let newWidth = view.bounds.width - 40
            switch result {
            case .success(let value):
                let ratio = value.image.size.width / value.image.size.height
                let newHeight = newWidth / ratio
                self.imageHeightAnchor.constant = newHeight
                self.refreshLayout()
            case .failure(let error):
                print(error) // The error happens
            }
        }
    }
    
    private func setupBinding() {
        permaLinkBtn.rx.tap
            .bind(to: viewModel.tapPermalink)
            .disposed(by: disposeBag)
    }
    
    private func refreshLayout() {
        collectionImage.sizeToFit()
        let contentHeight = 
            collectionImage.bounds.height +
            collectionItemName.bounds.height +
            collectionItemDescription.bounds.height
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        scrollView.isScrollEnabled = true
        view.layoutIfNeeded()
    }
}
