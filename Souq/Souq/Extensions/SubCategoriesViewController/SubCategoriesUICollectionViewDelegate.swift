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
    
    // MARK: Number of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    // MARK: Create Cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        // to be able to fill the cell with current category object data.
        let currentCategory = categoriesArray[indexPath.row]
        
        // to be able to show the current category image.
        let currentImageUrl = imageUrls[indexPath.row]
        let imageResource = ImageResource(downloadURL: URL(string: currentImageUrl)!)

        // to store the current category title in Arabic or in English.
        var categoryTitle = ""
        
        // to store the count of products in the current category
        let productCount = currentCategory.productCount
        
        // In case that the language was in English we are going to show the category data in cell into English.
        // if there any reuseable cell we will invoke the configureCell method so the custom cell can create it.
        // if there is no existing cell then we will modify the attributes of the new cell here in English.
        if isArabic == false {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = category.englishTitle!
                categoryNameLabel.text = "\(categoryTitle). (\(productCount ?? "0"))"
                categoryNameLabel.font = UIFont(name: "Montserrat", size: 17)
                
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
            // In case that the language was in Arabic we are going to show the category data in cell into Arabic.
            // if there any reuseable cell we will invoke the configureCell method so the custom cell can create it.
            // if there is no existing cell then we will modify the attributes of the new cell here in Arabic.
            
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = category.arabicTitle!
                categoryNameLabel.text = "\(categoryTitle). (\(productCount ?? "0"))"
                categoryNameLabel.font = UIFont(name: "GE Dinar One", size: 17)
                
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
