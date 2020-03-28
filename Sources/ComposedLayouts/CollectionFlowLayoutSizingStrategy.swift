import UIKit
import ComposedUI

open class CollectionFlowLayoutSizingStrategy {

    public enum SizingMode {
        case fixed(height: CGFloat)
        case automatic(isUniform: Bool)
        case aspect(ratio: CGFloat)
    }

    public let columnCount: Int
    public let sizingMode: SizingMode
    public let metrics: CollectionFlowLayoutMetrics
    public let prototype: UICollectionReusableView?

    public init(prototype: UICollectionReusableView?, columnCount: Int, sizingMode: SizingMode, metrics: CollectionFlowLayoutMetrics) {
        if case .automatic = sizingMode, prototype == nil {
            fatalError("Prototype cannot be nil when setting `sizingMode == .automatic`")
        }

        self.prototype = prototype
        self.columnCount = columnCount
        self.sizingMode = sizingMode
        self.metrics = metrics
    }

    private var cachedSizes: [Int: CGSize] = [:]
    private func cachedSize(forElementAt index: Int) -> CGSize? {
        switch sizingMode {
        case .aspect:
            return cachedSizes[index]
        case .fixed:
            return cachedSizes.values.first
        case let .automatic(isUniform):
            return isUniform ? cachedSizes.values.first : cachedSizes[index]
        }
    }

    open func size(forElementAt index: Int, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        if let size = cachedSize(forElementAt: index) { return size }

        var width: CGFloat {
            let interitemSpacing = CGFloat(columnCount - 1) * metrics.minimumInteritemSpacing
            let availableWidth = environment.contentSize.width
                - metrics.contentInsets.left - metrics.contentInsets.right
                - interitemSpacing
            return (availableWidth / CGFloat(columnCount)).rounded(.down)
        }

        switch sizingMode {
        case let .aspect(ratio):
            let size = CGSize(width: width, height: width * ratio)
            cachedSizes[index] = size
            return size
        case let .fixed(height):
            let size = CGSize(width: width, height: height)
            cachedSizes[index] = size
            return size
        case .automatic:
            let targetView: UIView?
            let targetSize = CGSize(width: width, height: 0)

            if let cell = prototype as? UICollectionViewCell {
                targetView = cell.contentView
            } else {
                targetView = prototype
            }

            let size = targetView?.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel)
                ?? .zero

            cachedSizes[index] = size
            return size
        }
    }

}

