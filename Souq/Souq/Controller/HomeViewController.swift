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

class HomeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var languageButton: UIButton!
    
    // MARK: Class Attributes
    
    // An array to store Category objects fetched from JSON response
    var categories = [Category]()
    // An array to store Category Image URLs fetched from JSON response.
    var imageUrls = [String]()
    // To check if the current language is Arabic or English.
    var isArabic: Bool = false
    
    // We will use this variable to store the web API url to get the sub categories of the current main category.
    var webApiUrl = ""
    
    // This is the category object we are going to pass to the next VC.
    var category: Category!
    
    // MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // We invoke this method to configure UICollectionView's edge insets.
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This variable is to store the web api url rsponsable for main categories
        let webApiUrl = generateApiUrl(usingCategoryId: 0, andCountryID: 1)
        
        // This method is to start performing the fetching data operation
        self.performDataFetch(webApiUrl: webApiUrl)
    }

    // MARK: IBActions
    @IBAction func languageButtonPressed(_ sender: Any) {
        // This code is to set localization for language button
        if languageButton.currentTitle == "عربي" && isArabic == false  {
            self.setLocalizationForLanguageButtonInEnglish()
        } else if languageButton.currentTitle == "English" && isArabic == true {
            self.setlocalizationForLanguageButtonInArabic()
        }
        
        // To reload the CollectionView data based on the new Localization Settings
        collectionView.reloadData()
    }
}

