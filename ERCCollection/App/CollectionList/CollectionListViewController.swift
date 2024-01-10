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

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CollectionListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        self.title = "List"
        collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.collectionList
            .filter({ !$0.isEmpty })
            .bind(to: collectionView.rx
                    .items(cellIdentifier: CollectionItemCell.identifier,
                           cellType: CollectionItemCell.self)) { (_, viewModel, cell) in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(CollectionItemViewModel.self)
            .bind(to: viewModel.selectCollection)
            .disposed(by: disposeBag)

        collectionView.rx.willDisplayCell
            .filter({
                let currentSection = $0.at.section
                let currentItem    = $0.at.row
                let allCellSection = self.collectionView.numberOfSections
                let numberOfItem   = self.collectionView.numberOfItems(inSection: currentSection)

                return currentSection == allCellSection - 1
                                        &&
                       currentItem >= numberOfItem - 1
            })
            .map({ _ in () })
            .bind(to: viewModel.scrollEnded)
            .disposed(by: disposeBag)
    }
}

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
           return 20.0
    }
}
