import UIKit
import ComposedUI

extension CollectionCoordinator: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = sectionProvider.sections[indexPath.section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
        }
        return section.sizeForItem(at: indexPath.item, traitCollection: collectionView.traitCollection)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        }
        return section.layoutMetrics(traitCollection: collectionView.traitCollection).contentInsets
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
        }
        return section.layoutMetrics(traitCollection: collectionView.traitCollection).minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        }
        return section.layoutMetrics(traitCollection: collectionView.traitCollection).minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
        }
        return section.referenceHeaderSize(traitCollection: collectionView.traitCollection)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else {
            return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
        }
        return section.referenceFooterSize(traitCollection: collectionView.traitCollection)
    }

}
