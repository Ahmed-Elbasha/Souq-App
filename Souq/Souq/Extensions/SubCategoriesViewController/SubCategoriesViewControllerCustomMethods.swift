//
//  SubCategoriesViewControllerCustomMethods.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/15/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire

extension SubCategoriesViewController {
    
    // MARK: Class's Data Initialization
    func initWithData(webApiUrl url: String, isArabic: Bool, andCategory category: Category) {
        self.webApiUrl = url
        self.isArabic = isArabic
        self.category = category
    }
    
    // MARK: Fetch Category Data From JSON Data.
    func fetchCategoriesData(webApiUrl: String, handler: @escaping(_ status: Bool) ->() ) {
        // To be able to save the current changes to persistent store.
        let managedContext = appDelegate?.persistentContainer.viewContext
        // To be able to add new object of its type.
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext!)
        
        // This request is to  fetch Category objects from JSON response.
        Alamofire.request(webApiUrl).responseJSON { (response) in
            guard let categories = response.result.value as? [Dictionary<String, AnyObject>] else {return}
            for category in categories {
                // To create new Category object.
                let newCategory = NSManagedObject(entity: categoryEntity!, insertInto: managedContext)
                
                // To store the value of category ID to the Category object.
                let categoryId = category["Id"] as! Int32
                newCategory.setValue(categoryId, forKey: "categoryId")
                
                // To store the value of category english title to the Category object.
                let englishTitle = category["TitleEN"] as! String
                newCategory.setValue(englishTitle, forKey: "englishTitle")
                
                // To store the value of category arabic title to the category object.
                let arabicTitle = category["TitleAR"] as! String
                newCategory.setValue(arabicTitle, forKey: "arabicTitle")
                
                // To store the value of category photo url to the category object.
                let photoUrl = category["Photo"] as! String
                newCategory.setValue(photoUrl, forKey: "photoUrl")
                
                // To store the value of product count to the category object.
                let productCount = category["ProductCount"] as! String
                newCategory.setValue(productCount, forKey: "productCount")
                
                // This code tries to save the Category object into persistent store.
                do {
                    try managedContext?.save()
                    print("Data Saved Successfully")
                    handler(true)
                } catch {
                    print("Operation Failed.. \(error.localizedDescription)")
                    handler(false)
                }
            }
        }    }
    
    // MARK: Store Category Data In Categories Array.
    func storeCategoriesIntoArray(completion: (_ status: Bool) ->() ) {
        // to be able to fetch Category objects data from persistent store.
        let managedContext = appDelegate?.persistentContainer.viewContext
        // to fetch Category objects data.
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            // to store Category elements into Array.
            categoriesArray = (try managedContext?.fetch(fetchRequest))!
            
            // to store Image URLS elements into Array.
            for category in categoriesArray {
                
                let categoryImageUrl = "http://souq.hardtask.co//Images/no_image.png"
                imageUrls.append(categoryImageUrl)
                
            }
            
            print("Data Fetched Successfully")
            completion(true)
        } catch {
            print("Operation Failed. \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // The Function That Will invoke Fetch & Store Category Data and Collection View's ReloadData()
    func performDataFetch(webApiUrl: String) {
        fetchCategoriesData(webApiUrl: webApiUrl) { (complete) in
            if complete {
                self.storeCategoriesIntoArray(completion: { (complete) in
                    if complete {
                        self.collectionView.reloadData()
                    }
                })
            }
        }
    }
    
    // MARK: Localization
    func setLocalizationForCategoryNameLabelInArabic() {
        categoryNameLabel.text = category.arabicTitle
    }
    
    func setLocalizationForCategoryNameLabelInEnglish() {
        categoryNameLabel.text = category.englishTitle
    }
    
    func setLocalizationForLanguageButtonInEnglish() {
        languageButton.setTitle("English", for: .normal)
        languageButton.titleLabel?.font = UIFont(name: "Montserrat", size: 17)
        isArabic = true
    }
    
    func setLocalizationForLanguageButtonInArabic() {
        languageButton.setTitle("عربي", for: .normal)
        languageButton.titleLabel?.font = UIFont(name: "GE Dinar One", size: 17)
        isArabic = false
    }
}
