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
    
    // MARK: IBOutlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Class Attributes
    var categoriesArray = [Category]()
    var imageUrls = [String]()
    
    var webApiUrl = ""
    var isArabic: Bool = false
    var category: Category!

    // MARK: View Controller Life Cycle Methods.
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
    
    
    
    // MARK: IBActions
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
