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
    
    // An array to store Category objects fetched from JSON response
    var categoriesArray = [Category]()
    // An array to store Category Image URLs fetched from JSON response.
    var imageUrls = [String]()
    
    // We will use this variable to store the incoming variable from previous VC.
    var webApiUrl = ""
    
    // To check if the current language is Arabic or English.
    var isArabic: Bool = false
    
    // This is the category object we are going to use it for UI Localization.
    // We receive it from previous VC.
    var category: Category!

    // MARK: View Controller Life Cycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // We invoke this method to configure UICollectionView's edge insets.
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This method is to start performing the fetching data operation
        self.performDataFetch(webApiUrl: webApiUrl)
        
        // This code is to set the localization of categoryNameLabel once the view appears.
        if isArabic == false {
            self.setLocalizationForCategoryNameLabelInEnglish()
        } else {
            self.setLocalizationForCategoryNameLabelInArabic()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func languageButtonPressed(_ sender: Any) {
        // This code is to set localization for language button
        if languageButton.currentTitle == "عربي" && isArabic == false {
            self.setLocalizationForLanguageButtonInEnglish()
            self.setLocalizationForCategoryNameLabelInArabic()
        } else if languageButton.currentTitle == "English" && isArabic == true {
            self.setLocalizationForLanguageButtonInArabic()
            self.setLocalizationForCategoryNameLabelInEnglish()
        }
        
        // To reload the CollectionView data based on the new Localization Settings
        collectionView.reloadData()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
