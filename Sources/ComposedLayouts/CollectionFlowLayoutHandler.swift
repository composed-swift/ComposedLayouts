import UIKit
import ComposedUI

public struct CollectionFlowLayoutMetrics {
    public var contentInsets: UIEdgeInsets = .zero
    public var minimumLineSpacing: CGFloat = 0
    public var minimumInteritemSpacing: CGFloat = 0
    public init() { }
}

public protocol CollectionFlowLayoutHandler: CollectionSectionProvider {
    func sizeForItem(at index: Int, traitCollection: UITraitCollection) -> CGSize
    func referenceHeaderSize(traitCollection: UITraitCollection) -> CGSize
    func referenceFooterSize(traitCollection: UITraitCollection) -> CGSize
    func layoutMetrics(traitCollection: UITraitCollection) -> CollectionFlowLayoutMetrics
}

public extension CollectionFlowLayoutHandler {
    func referenceHeaderSize(traitCollection: UITraitCollection) -> CGSize { return .zero }
    func referenceFooterSize(traitCollection: UITraitCollection) -> CGSize { return .zero }
    func layoutMetrics(traitCollection: UITraitCollection) -> CollectionFlowLayoutMetrics { return .init() }
}
