//
//  SubCategoriesViewController.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/14/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Kingfisher

class SubCategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoriesArray = [Category]()
    var imageUrls = [String]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var webApiUrl = ""
    var isArabic: Bool = false
    var category: Category!

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performDataFetch(webApiUrl: webApiUrl)
        if isArabic == false {
            categoryNameLabel.text = category.englishTitle
        } else {
            categoryNameLabel.text = category.arabicTitle
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initWithData(webApiUrl url: String, isArabic: Bool, andCategory category: Category) {
        self.webApiUrl = url
        self.isArabic = isArabic
        self.category = category
    }
    
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
    
    @IBAction func languageButtonPressed(_ sender: Any) {
        if languageButton.currentTitle == "عربي" && isArabic == false {
            languageButton.setTitle("English", for: .normal)
            languageButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 17)
            categoryNameLabel.text = category.arabicTitle
            isArabic = true
        } else if languageButton.currentTitle == "English" && isArabic == true {
            languageButton.setTitle("عربي", for: .normal)
            languageButton.titleLabel?.font = UIFont(name: "GE Dinar One Medium", size: 17)
            categoryNameLabel.text = category.englishTitle
            isArabic = false
        }
        collectionView.reloadData()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
