import UIKit
import ComposedUI

extension CollectionCoordinator: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = sectionProvider.sections[indexPath.section] as? CollectionFlowLayoutHandler else { return .zero }
        return section.sizeForItem(at: indexPath.item)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return .zero }
        return section.contentInsets
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return 0 }
        return section.minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return 0 }
        return section.minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return .zero }
        return section.referenceHeaderSize
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let section = sectionProvider.sections[section] as? CollectionFlowLayoutHandler else { return .zero }
        return section.referenceFooterSize
    }

}
