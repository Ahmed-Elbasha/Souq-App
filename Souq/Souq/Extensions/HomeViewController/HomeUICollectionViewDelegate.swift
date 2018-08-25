//
//  HomeUICollectionViewDelegate.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/15/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData
import Kingfisher

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Number of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    // MARK: Create Cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        let currentCategory = categories[indexPath.row]
        let currentImageUrl = imageUrls[indexPath.row]
        let imageResource = ImageResource(downloadURL: URL(string: currentImageUrl)!)
        var categoryTitle = ""
        let itemCount = currentCategory.productCount
        
        if isArabic == false {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = currentCategory.englishTitle!
                cell.categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                cell.categoryLabel.font = UIFont(name: "Montserrat", size: 17)
                
                if currentImageUrl == "http://souq.hardtask.co//Images/no_image.png" {
                    cell.categoryImageImageView.image = UIImage(named: "cat_no_img")
                } else {
                    cell.categoryImageImageView.kf.setImage(with: imageResource)
                }
                
            } else if cell.isKind(of: CategoryCollectionViewCell.self) {
                cell.configureCell(withCategory: currentCategory, Resource: imageResource, andIsArabic: isArabic)
            }
        } else {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = currentCategory.arabicTitle!
                cell.categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                cell.categoryLabel.font = UIFont(name: "GE Dinar One", size: 17)
                
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
    
    // MARK: The action performed when a cell selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = categories[indexPath.row]
        
        let subCategoriesLength = category.subCategories
        
        webApiUrl = generateApiUrl(usingCategoryId: Int32(categoryId), andCountryID: countryId)
        
        if subCategoriesLength == 0 {
            return
        } else {
            let subCategoriesVC = storyboard?.instantiateViewController(withIdentifier: "SubCategoriesViewController") as! SubCategoriesViewController
            subCategoriesVC.initWithData(webApiUrl: webApiUrl, isArabic: isArabic, andCategory: category)
            self.present(subCategoriesVC, animated: true, completion: nil)
        }
        
    }
}
