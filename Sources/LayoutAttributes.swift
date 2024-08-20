//
//  LayoutAttributes.swift
//  FlowLayout
//
//  Created by Ben Shutt on 20/08/2024.
//

#if canImport(UIKit)
import UIKit

/// Essentially an extension of `FlowLayout` adding a cache mapping index path
/// to `UICollectionViewLayoutAttributes`
struct LayoutAttributes<Element: FlowLayoutSized> {
    typealias Layout = FlowLayout<Element>
    typealias Frame = Layout.Frame

    var flowLayout: Layout
    var attributes: [IndexPath: UICollectionViewLayoutAttributes]

    var contentSize: CGSize {
        flowLayout.contentSize
    }

    var frames: [[Frame]] {
        flowLayout.frames
    }

    var numberOfSections: Int {
        flowLayout.frames.count
    }

    func numberOfItemsInSection(section: Int) -> Int {
        flowLayout.frames[section].count
    }

    init(flowLayout: Layout = Layout()) {
        self.flowLayout = flowLayout

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

    subscript(indexPath: IndexPath) -> Frame {
        flowLayout[indexPath]
    }
}

#endif
