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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
    func fetchCategoriesData(handler: @escaping(_ status: Bool) -> ()) {
        Alamofire.request(generateApiUrl(usingCategoryId: 0, andCountryID: 1)).responseJSON { (response) in
            guard let categories = response.result.value as? [Dictionary<String, AnyObject>] else {return}
            for category in categories {
                let categoryId = category["Id"] as! Int32
                let englishTitle = category["TitleEN"] as! String
                let arabicTitle = category["TitleAR"] as! String
                let photoUrl = category["Photo"] as! String
                let productCount = category["ProductCount"] as! String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var preferredStatusBarStyle: UIStatusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

