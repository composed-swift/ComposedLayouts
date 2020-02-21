import UIKit
import ComposedUI

#if canImport(FlowLayout)
import FlowLayout

protocol FlowLayoutSectionHandler: CollectionFlowLayoutHandler {
    func itemAlignment(environment: CollectionFlowLayoutEnvironment) -> LayoutAlignment
    func backgroundRegion(environment: CollectionFlowLayoutEnvironment) -> LayoutRegion
    func backgroundInsets(environment: CollectionFlowLayoutEnvironment) -> UIEdgeInsets
}

protocol FlowLayoutGlobalHandler: CollectionCoordinatorDelegate {
    func globalHeaderHeight(environment: CollectionFlowLayoutEnvironment) -> CGFloat
    func globalFooterHeight(environment: CollectionFlowLayoutEnvironment) -> CGFloat
}

extension CollectionCoordinator: FlowLayoutDelegate {

    private func environment(collectionView: UICollectionView) -> CollectionFlowLayoutEnvironment {
        return CollectionFlowLayoutEnvironment(contentSize: collectionView.bounds.size, traitCollection: collectionView.traitCollection)
    }

    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, alignmentInSection section: Int) -> LayoutAlignment {
        guard let section = sectionProvider.sections[section] as? FlowLayoutSectionHandler else { return .none }
        return section.itemAlignment(environment: environment(collectionView: collectionView))
    }

    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, regionForBackgroundInSection section: Int) -> LayoutRegion {
        guard let section = sectionProvider.sections[section] as? FlowLayoutSectionHandler else { return .none }
        return section.backgroundRegion(environment: environment(collectionView: collectionView))
    }

    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetsForBackgroundInSection section: Int) -> UIEdgeInsets {
        guard let section = sectionProvider.sections[section] as? FlowLayoutSectionHandler else { return .zero }
        return section.backgroundInsets(environment: environment(collectionView: collectionView))
    }

    public func heightForGlobalHeader(in collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat {
        return (delegate as? FlowLayoutGlobalHandler)?.globalHeaderHeight(environment: environment(collectionView: collectionView)) ?? 0
    }

    public func heightForGlobalFooter(in collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat {
        return (delegate as? FlowLayoutGlobalHandler)?.globalFooterHeight(environment: environment(collectionView: collectionView)) ?? 0
    }

}
#endif
