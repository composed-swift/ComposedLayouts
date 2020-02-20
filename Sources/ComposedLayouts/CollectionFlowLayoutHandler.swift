import UIKit
import ComposedUI

public struct CollectionFlowLayoutMetrics {
    public var contentInsets: UIEdgeInsets
    public var minimumLineSpacing: CGFloat
    public var minimumInteritemSpacing: CGFloat
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
    func contentInsets(traitCollection: UITraitCollection) -> UIEdgeInsets { return .zero }
    func minimumLineSpacing(traitCollection: UITraitCollection) -> CGFloat { return 0 }
    func minimumInteritemSpacing(traitCollection: UITraitCollection) -> CGFloat { return 0 }
}
