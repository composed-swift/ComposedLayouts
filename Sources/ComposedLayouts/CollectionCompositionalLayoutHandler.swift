import UIKit
import ComposedUI

@available(iOS 13.0, *)
public protocol CompositionalLayoutHandler: CollectionSectionProvider {
    func compositionalLayoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}
