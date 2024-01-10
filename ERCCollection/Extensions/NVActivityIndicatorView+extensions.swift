//
//  NVActivityIndicatorView+extensions.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import NVActivityIndicatorView
import RxSwift

extension Reactive where Base: NVActivityIndicatorView {
    
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { activityIndicator, active in
            if active {
                print("start loading")
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
