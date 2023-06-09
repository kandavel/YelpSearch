//
//  CollectionView.swift
//  Vmedia
//
//  Created by kandavel on 19/03/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func register(reusableViewType: UICollectionReusableView.Type,
                  ofKind kind: String = UICollectionView.elementKindSectionHeader,
                  bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func register(reusableViewTypeFooter: UICollectionReusableView.Type,
                  ofKind kind: String = UICollectionView.elementKindSectionFooter,
                  bundle: Bundle? = nil) {
        let className = reusableViewTypeFooter.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func register(reusableViewTypes: [UICollectionReusableView.Type],
                  ofKind kind: String = UICollectionView.elementKindSectionHeader,
                  bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    func customDequeueCell<T: UICollectionViewCell>(with type: T.Type,
                                                    for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else{
            fatalError("Could not dequeue cell with identifier: \(type.className)")
        }
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                          for indexPath: IndexPath,
                                                          ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
