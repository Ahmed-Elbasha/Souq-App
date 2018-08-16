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
        let managedContext = appDelegate?.persistentContainer.viewContext
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext!)
        
        Alamofire.request(webApiUrl).responseJSON { (response) in
            guard let categories = response.result.value as? [Dictionary<String, AnyObject>] else {return}
            for category in categories {
                let newCategory = NSManagedObject(entity: categoryEntity!, insertInto: managedContext)
                
                let categoryId = category["Id"] as! Int32
                newCategory.setValue(categoryId, forKey: "categoryId")
                let englishTitle = category["TitleEN"] as! String
                newCategory.setValue(englishTitle, forKey: "englishTitle")
                let arabicTitle = category["TitleAR"] as! String
                newCategory.setValue(arabicTitle, forKey: "arabicTitle")
                let photoUrl = category["Photo"] as! String
                newCategory.setValue(photoUrl, forKey: "photoUrl")
                let productCount = category["ProductCount"] as! String
                newCategory.setValue(productCount, forKey: "productCount")
                
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
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            categoriesArray = (try managedContext?.fetch(fetchRequest))!
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
}
