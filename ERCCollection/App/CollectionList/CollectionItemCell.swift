//
//  CollectionItemCell.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/4.
//

import UIKit
import Kingfisher

class CollectionItemCell: UICollectionViewCell {
    
    static let identifier = "CollectionItemCell"
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with viewModel: CollectionItemViewModel) {
        nameLabel.text = viewModel.name
        if isSVGFile(url: viewModel.imageUrl) {
            let imageSize = (UIScreen.main.bounds.width - 60) / 2
            let processor = SVGProcessor(size: CGSize(width: imageSize, height: imageSize))
            collectionImage.svgImage(from: viewModel.imageUrl, processor: processor)
        } else {
            collectionImage.kf.setImage(with: viewModel.imageUrl)
        }
    }
    
    private func isSVGFile(url: URL) -> Bool {
        let svgFileExtensions = ["svg"]

        let fileExtension = url.pathExtension.lowercased()
        return svgFileExtensions.contains(fileExtension)
    }
}
