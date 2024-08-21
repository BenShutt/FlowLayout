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
    func size(in collectionViewSize: CGSize) -> CGSize
}

// MARK: - FlowLayout

/// A 2D array of rows of elements and their associated frames
public struct FlowLayout<Element: FlowLayoutSized> {

    /// An element to layout and its associated frame
    public struct Frame: Identifiable {

        /// The elements index in the 2D array.
        /// Section is the row index
        /// Item in the index in the row
        public let id: IndexPath

        /// An element to layout
        public let element: Element

        /// The associated frame in the layout
        public let frame: CGRect

        /// Public memberwise initializer
        public init(
            id: IndexPath,
            element: Element,
            frame: CGRect
        ) {
            self.id = id
            self.element = element
            self.frame = frame
        }
    }

    /// Size of the content
    public let contentSize: CGSize

    /// Rows of elements and their associated frames
    public let frames: [[Frame]]

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
