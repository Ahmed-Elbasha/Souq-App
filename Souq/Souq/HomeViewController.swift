//
//  HomeViewController.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/12/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var languageButton: UIButton!
    
    var categories = [Category]()
    var imageUrls = [String]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var isArabic: Bool = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
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
                cell.categoryImageImageView.kf.setImage(with: imageResource)
            } else if cell.isKind(of: UICollectionViewCell.self) {
                cell.configureCell(withCategory: currentCategory, Resource: imageResource, andIsArabic: isArabic)
            }
        } else {
            if cell.isKind(of: UICollectionViewCell.self) {
                categoryTitle = currentCategory.arabicTitle!
                cell.categoryLabel.text = "\(categoryTitle). (\(itemCount ?? "0"))"
                cell.categoryImageImageView.kf.setImage(with: imageResource)
            } else if cell.isKind(of: UICollectionViewCell.self) {
                cell.configureCell(withCategory: currentCategory, Resource: imageResource, andIsArabic: isArabic)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webApiUrl = generateApiUrl(usingCategoryId: Int32(indexPath.row), andCountryID: countryId)
        let category = categories[indexPath.row]
        
        let subCategoriesVC = storyboard?.instantiateViewController(withIdentifier: "SubCategoriesViewController") as? SubCategoriesViewController
        subCategoriesVC?.initWithData(webApiUrl: webApiUrl, isArabic: isArabic, andCategory: category)
        self.present(subCategoriesVC!, animated: true, completion: nil)
    }
    
    func fetchCategoriesData(webApiUrl: String, handler: @escaping(_ status: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)
        
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
                    try managedContext.save()
                    print("Data Saved Successfully")
                    handler(true)
                } catch {
                    print("Operation Failed.. \(error.localizedDescription)")
                    handler(false)
                }
            }
        }
    }
    
    func storeCategoriesIntoArray(completion: (_ status: Bool) -> () ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            categories = try managedContext.fetch(fetchRequest)
            
            for category in categories {
                let categoryImageUrl = category.photoUrl
                imageUrls.append(categoryImageUrl!)
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
                    if complete {}
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = self.view.frame.origin.x
        screenHeight = self.view.frame.origin.y
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let webApiUrl = generateApiUrl(usingCategoryId: 0, andCountryID: 1)
        performDataFetch(webApiUrl: webApiUrl)
    }

    @IBAction func languageButtonPressed(_ sender: Any) {
        if languageButton.currentTitle == "عربي" && isArabic == false  {
            languageButton.setTitle("English", for: UIControlState.normal)
            isArabic = true
        } else if languageButton.currentTitle == "English" && isArabic == true {
            languageButton.setTitle("عربي", for: UIControlState.normal)
            isArabic = false
        }
    }
}

