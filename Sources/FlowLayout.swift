//
//  FlowLayout.swift
//  FlowLayout
//
//  Created by Ben Shutt on 19/08/2024.
//

import SwiftUI

/// An entity that has a size in a flow layout
public protocol FlowLayoutSized {

    /// Get the size of an element given the size of the collection view
    /// - Parameter collectionViewSize: Size of the collection view
    /// - Returns: Size of this element in the collection view
    func cellSize(in collectionViewSize: CGSize) -> CGSize
}

// MARK: - FlowLayout

/// A 2D array of rows of elements and their associated frames
public struct FlowLayout<Element: FlowLayoutSized> {

    /// An element to layout and its associated frame
    public struct Frame {

        /// An element to layout
        public var element: Element

        /// The associated frame in the layout
        public var frame: CGRect

        /// Public memberwise initializer
        public init(
            element: Element,
            frame: CGRect
        ) {
            self.element = element
            self.frame = frame
        }
    }

    /// Size of the content
    public var contentSize: CGSize

    /// Rows of elements and their associated frames
    public var frames: [[Frame]]

    /// Public memberwise initializer
    public init(
        contentSize: CGSize = .zero,
        frames: [[Frame]] = []
    ) {
        self.contentSize = contentSize
        self.frames = frames
    }

    /// Subscript mapping index path into 2D array
    public subscript(indexPath: IndexPath) -> Frame {
        frames[indexPath.section][indexPath.item]
    }
}
