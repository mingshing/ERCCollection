//
//  URL+extensions.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/10.
//

import Foundation
extension URL {

    var isSVGFile: Bool {
        let svgFileExtensions = ["svg"]

        let fileExtension = self.pathExtension.lowercased()
        return svgFileExtensions.contains(fileExtension)
    }
}
