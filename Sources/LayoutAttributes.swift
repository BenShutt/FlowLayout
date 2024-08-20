//
//  LayoutAttributes.swift
//  FlowLayout
//
//  Created by Ben Shutt on 20/08/2024.
//

#if canImport(UIKit)
import UIKit

/// Essentially an extension of `FlowLayout` adding `UICollectionViewLayoutAttributes`
/// to be used by `CollectionViewFlowLayout`.
struct LayoutAttributes<Element: FlowLayoutSized> {
    var contentSize: CGSize
    var frames: [[FlowLayout<Element>.Frame]]
    var attributes: [IndexPath: UICollectionViewLayoutAttributes]

    var numberOfSections: Int {
        frames.count
    }

    func numberOfItemsInSection(section: Int) -> Int {
        frames[section].count
    }

    init() {
        contentSize = .zero
        frames = []
        attributes = [:]
    }

    init(flowLayout: FlowLayout<Element>) {
        contentSize = flowLayout.contentSize
        frames = flowLayout.frames

        let sections = flowLayout.frames.enumerated()
        attributes = sections.reduce(into: [:]) { map, row in
            row.element.enumerated().forEach { item, frame in
                let indexPath = IndexPath(item: item, section: row.offset)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame.frame
                map[indexPath] = attributes
            }
        }
    }

    subscript(indexPath: IndexPath) -> Element {
        frames[indexPath.section][indexPath.item].element
    }
}

#endif
