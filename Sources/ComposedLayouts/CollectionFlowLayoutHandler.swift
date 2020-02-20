import UIKit
import ComposedUI

public struct CollectionFlowLayoutMetrics {
    public var contentInsets: UIEdgeInsets = .zero
    public var minimumLineSpacing: CGFloat = 0
    public var minimumInteritemSpacing: CGFloat = 0
    public init() { }
}

public protocol CollectionFlowLayoutHandler: CollectionSectionProvider {
    func sizeForItem(at index: Int, suggested: CGSize, traitCollection: UITraitCollection) -> CGSize
    func referenceHeaderSize(suggested: CGSize, traitCollection: UITraitCollection) -> CGSize
    func referenceFooterSize(suggested: CGSize, traitCollection: UITraitCollection) -> CGSize
    func layoutMetrics(suggested metrics: CollectionFlowLayoutMetrics, traitCollection: UITraitCollection) -> CollectionFlowLayoutMetrics
}

public extension CollectionFlowLayoutHandler {
    func sizeForItem(at index: Int, suggested: CGSize, traitCollection: UITraitCollection) -> CGSize { return suggested }
    func referenceHeaderSize(suggested: CGSize, traitCollection: UITraitCollection) -> CGSize { return suggested }
    func referenceFooterSize(suggested: CGSize, traitCollection: UITraitCollection) -> CGSize { return suggested }
    func layoutMetrics(suggested: CollectionFlowLayoutMetrics, traitCollection: UITraitCollection) -> CollectionFlowLayoutMetrics { return suggested }
}
