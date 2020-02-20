import UIKit
import ComposedUI

@available(iOS 13.0, *)
public extension UICollectionViewCompositionalLayout {

    convenience init(coordinator: CollectionCoordinator) {
        self.init { [weak coordinator] index, environment in
            guard let section = coordinator?.sectionProvider.sections[index] as? CompositionalLayoutHandler else { return nil }
            return section.compositionalLayoutSection(environment: environment)
        }
    }

}
