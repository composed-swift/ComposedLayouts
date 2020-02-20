import UIKit
import ComposedUI

public protocol CollectionFlowLayoutHandler: CollectionSectionProvider {
    func sizeForItemAt(at index: Int) -> CGSize
    var referenceHeaderSize: CGSize
    var referenceFooterSize: CGSize
    var contentInsets: UIEdgeInsets
    var minimumLineSpacing: CGFloat
    var minimumInteritemSpacing: CGFloat
}
