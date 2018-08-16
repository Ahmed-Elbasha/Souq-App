//
//  SubCategoriesUICollectionViewDelegate.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/15/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension SubCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        let currentCategory = categoriesArray[indexPath.row]
        let currentImageUrl = imageUrls[indexPath.row]
        
        let imageResource = ImageResource(downloadURL: URL(string: currentImageUrl)!)

        var categoryTitle = ""
        let productCount = currentCategory.productCount
        
        if isArabic == false {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = category.englishTitle!
                categoryNameLabel.text = "\(categoryTitle). (\(productCount ?? "0"))"
                categoryNameLabel.font = UIFont(name: "GE Dinar One Medium", size: 17)
                
                let emptyStateImage = #imageLiteral(resourceName: "cat_no_img")
                
                if currentImageUrl == "http://souq.hardtask.co//Images/no_image.png" {
                    cell.categoryImageImageView.image = emptyStateImage
                } else {
                    cell.categoryImageImageView.kf.setImage(with: imageResource)
                }
                
            } else if cell.isKind(of: CategoryCollectionViewCell.self) {
                cell.configureCell(withCategory: currentCategory, Resource: imageResource, andIsArabic: isArabic)
            }
        } else if isArabic == true {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = category.arabicTitle!
                categoryNameLabel.text = "\(categoryTitle). (\(productCount ?? "0"))"
                categoryNameLabel.font = UIFont(name: "GE Dinar One Medium", size: 17)
                
                if currentImageUrl == "http://souq.hardtask.co//Images/no_image.png" {
                    cell.categoryImageImageView.image = UIImage(named: "cat_no_img")
                } else {
                    cell.categoryImageImageView.kf.setImage(with: imageResource)
                }
                
            } else if cell.isKind(of: CategoryCollectionViewCell.self) {
                cell.configureCell(withCategory: currentCategory, Resource: imageResource, andIsArabic: isArabic)
            }
        }
        
        return cell
    }
}
