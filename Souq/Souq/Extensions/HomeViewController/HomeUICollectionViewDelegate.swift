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
        
        // to be able to fill the cell with current category object data.
        let currentCategory = categories[indexPath.row]
        
        // to be able to show the current category image.
        let currentImageUrl = imageUrls[indexPath.row]
        let imageResource = ImageResource(downloadURL: URL(string: currentImageUrl)!)
        
        // to store the current category title in Arabic or in English.
        var categoryTitle = ""
        
        // to store the count of products in the current category
        let itemCount = currentCategory.productCount
        
        
        // In case that the language was in English we are going to show the category data in cell into English.
        // if there any reuseable cell we will invoke the configureCell method so the custom cell can create it.
        // if there is no existing cell then we will modify the attributes of the new cell here in English.
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
            // In case that the language was in Arabic we are going to show the category data in cell into Arabic.
            // if there any reuseable cell we will invoke the configureCell method so the custom cell can create it.
            // if there is no existing cell then we will modify the attributes of the new cell here in Arabic.
            
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
        
        // To pass the current selected category to the next VC.
        let category = categories[indexPath.row]
        
        // To check if there are sub categories or not to be shown
        let subCategoriesLength = category.subCategories
        
        // To generate the suitable web API url for the selected category.
        webApiUrl = generateApiUrl(usingCategoryId: Int32(categoryId), andCountryID: countryId)
        
        // We will check if there is sub categories for the selected category or not if there nothing then we will abort the operation if there is then we will prroceed with the implementation.
        if subCategoriesLength == 0 {
            return
        } else {
            let subCategoriesVC = storyboard?.instantiateViewController(withIdentifier: "SubCategoriesViewController") as! SubCategoriesViewController
            subCategoriesVC.initWithData(webApiUrl: webApiUrl, isArabic: isArabic, andCategory: category)
            self.present(subCategoriesVC, animated: true, completion: nil)
        }
        
    }
}
