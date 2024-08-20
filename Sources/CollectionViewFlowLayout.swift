//
//  CollectionViewFlowLayout.swift
//  FlowLayout
//
//  Created by Ben Shutt on 19/08/2024.
//

#if canImport(UIKit)
import UIKit

/// A `UICollectionViewLayout` for building a flow layout
open class CollectionViewFlowLayout<Element: FlowLayoutSized>: UICollectionViewLayout {

    /// Alias to a flow layout with the generic element
    public typealias Layout = FlowLayout<Element>

    /// Map an index path to its corresponding layout attributes
    public typealias AttributesMap = [IndexPath: UICollectionViewLayoutAttributes]

    /// Configuration properties of the flow layout
    open var configuration = FlowLayoutConfiguration()

    /// The elements and their associated frames
    private var layout = Layout()

    /// Cache of the layout attributes
    private var attributes: AttributesMap = [:]

    // MARK: - UICollectionViewLayout

    override open func prepare() {
        super.prepare()
        redrawLayout()
    }

    override open var collectionViewContentSize: CGSize {
        layout.contentSize
    }

    override open func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {
        guard let collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override open func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        attributes[indexPath]
    }

    override open func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        attributes.values.filter { attributes in
            rect.intersects(attributes.frame)
        }
    }

    // MARK: - Attributes

    /// Make a new layout attributes instance
    /// - Parameters:
    ///   - indexPath: Index path of the cell
    ///   - frame: Frame of the cell
    /// - Returns: A new layout attributes instance
    private func makeAttributes(
        indexPath: IndexPath,
        frame: CGRect
    ) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        return attributes
    }

    // MARK: - Layout

    /// The content to layout in the collection view
    open func redraw(elements: [Element]) {
        redrawLayout(elements: elements)
        invalidateLayout()
    }

    /// Redraw with the existing layout
    private func redrawLayout() {
        let rows = layout.frames.flatMap { $0 }
        let elements = rows.map { $0.element }
        redrawLayout(elements: elements)
    }

    /// Reset and re-build the layout properties
    private func redrawLayout(elements: [Element]) {
        guard let collectionView else {
            layout = Layout()
            attributes = [:]
            return
        }

        layout = FlowLayoutBuilder(
            collectionViewSize: collectionView.bounds.size,
            configuration: configuration
        )
        .build(elements: elements)

        let sections = layout.frames.enumerated()
        attributes = sections.reduce(into: [:]) { map, row in
            row.element.enumerated().forEach { item, frame in
                let indexPath = IndexPath(item: item, section: row.offset)
                map[indexPath] = makeAttributes(
                    indexPath: indexPath,
                    frame: frame.frame
                )
            }
        }
    }

    /// Subscript mapping index path into 2D array
    open subscript(indexPath: IndexPath) -> Layout.Frame {
        layout[indexPath]
    }
}
#endif
