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
    
    func configureCell(withCategory category: Category, Resource resource: ImageResource, andIsArabic: Bool) {
        
    }
}
