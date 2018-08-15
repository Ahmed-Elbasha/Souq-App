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
    
    @IBOutlet weak var categoryImageImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var fullCategoryLabelValue = ""
    
    func configureCell(withCategory category: Category, Resource resource: ImageResource, andIsArabic isArabic: Bool) {
        var categoryTitle = ""
        let itemCount = category.productCount
        
        if isArabic == false {
                categoryTitle = category.englishTitle!
                categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                categoryLabel.font = UIFont(name: "Montserrat-Regular", size: 17)
                categoryImageImageView.kf.setImage(with: resource, placeholder: UIImage(named: "cat_no_img"), options: nil, progressBlock: nil, completionHandler: nil)

        } else {
                categoryTitle = category.arabicTitle!
                categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                categoryLabel.font = UIFont(name: "GE Dinar One Medium", size: 17)
                categoryImageImageView.kf.setImage(with: resource, placeholder: UIImage(named: "cat_no_img"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }