import UIKit
import ComposedUI

extension CollectionCoordinator: UICollectionViewDelegateFlowLayout {

    private func suggestedMetrics(for layout: UICollectionViewFlowLayout) -> CollectionFlowLayoutMetrics {
        var metrics = CollectionFlowLayoutMetrics()
        metrics.contentInsets = layout.sectionInset
        metrics.minimumInteritemSpacing = layout.minimumInteritemSpacing
        metrics.minimumLineSpacing = layout.minimumLineSpacing
        return metrics
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let suggested = layout.estimatedItemSize == .zero ? layout.itemSize : layout.estimatedItemSize
        guard let section = sectionProvider.sections[indexPath.section] as? CollectionFlowLayoutHandler else { return suggested }
        return section.sizeForItem(at: indexPath.item, suggested: suggested, traitCollection: collectionView.traitCollection)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return layout.sectionInset }
        return section.layoutMetrics(suggested: suggestedMetrics(for: layout), traitCollection: collectionView.traitCollection).contentInsets
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return layout.minimumLineSpacing }
        return section.layoutMetrics(suggested: suggestedMetrics(for: layout), traitCollection: collectionView.traitCollection).minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return layout.minimumInteritemSpacing }
        return section.layoutMetrics(suggested: suggestedMetrics(for: layout), traitCollection: collectionView.traitCollection).minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return layout.headerReferenceSize }
        return section.referenceHeaderSize(suggested: layout.headerReferenceSize, traitCollection: collectionView.traitCollection)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return layout.footerReferenceSize }
        return section.referenceFooterSize(suggested: layout.footerReferenceSize, traitCollection: collectionView.traitCollection)
    }

}
