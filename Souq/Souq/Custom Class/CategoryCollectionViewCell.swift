//
//  CategoryCollectionViewCell.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/13/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var categoryImageImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // This method configures how the cell will be shaped
    func configureCell(withCategory category: Category, Resource resource: ImageResource, andIsArabic isArabic: Bool) {
        
        // to store the current category title in Arabic or in English.
        var categoryTitle = ""
        
        // to store the count of products in the current category
        let itemCount = category.productCount
        
        
        // In case that the language was in English we are going to show the category data in cell into English.
        if isArabic == false {
            categoryTitle = category.englishTitle!
            categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
            categoryLabel.font = UIFont(name: "Montserrat", size: 17)
            
            if category.photoUrl == "http://souq.hardtask.co//Images/no_image.png" {
                categoryImageImageView.image = UIImage(named: "cat_no_img")
            } else {
                categoryImageImageView.kf.setImage(with: resource)
            }

        } else {
            // In case that the language was in Arabic we are going to show the category data in cell into Arabic.
            
                categoryTitle = category.arabicTitle!
                categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                categoryLabel.font = UIFont(name: "GE Dinar One", size: 17)
            
            if category.photoUrl == "http://souq.hardtask.co//Images/no_image.png" {
                categoryImageImageView.image = UIImage(named: "cat_no_img")
            } else {
                categoryImageImageView.kf.setImage(with: resource)
            }
            }
        }
    }
