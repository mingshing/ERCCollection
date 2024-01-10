//
//  UIImageView+extensions.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import UIKit

extension UIImageView {

    func calculateHeightForAspectFit(width: CGFloat) -> CGFloat {
        guard let image = self.image else { return 0.0 }
        let aspectRatio = image.size.width / image.size.height
        print(aspectRatio)
        return width / aspectRatio
    }
}
