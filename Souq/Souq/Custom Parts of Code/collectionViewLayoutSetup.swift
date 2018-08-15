//
//  collectionViewLayoutSetup.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/13/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit

func setCollectionViewLayout(collectionView: UICollectionView, itemWidth: CGFloat, itemHeight: CGFloat) {
    let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionLayout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15)
    collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    collectionLayout.minimumInteritemSpacing = 10
    collectionLayout.minimumLineSpacing = 10
    collectionView.collectionViewLayout = collectionLayout
}


