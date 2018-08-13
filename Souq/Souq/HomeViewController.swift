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
    
    var categories = [Category]()
    var imageUrls = [String]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func fetchCategoriesData(handler: @escaping(_ status: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)
        
        Alamofire.request(generateApiUrl(usingCategoryId: 0, andCountryID: 1)).responseJSON { (response) in
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
    
    func performDataFetch() {
        fetchCategoriesData { (complete) in
            if complete {
                self.storeCategoriesIntoArray(completion: { (complete) in
                    if complete {}
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var preferredStatusBarStyle: UIStatusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        screenWidth = self.view.frame.origin.x
        screenHeight = self.view.frame.origin.y
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performDataFetch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

