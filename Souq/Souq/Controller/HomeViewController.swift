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
    var categories = [Category]()
    var imageUrls = [String]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var isArabic: Bool = false
    
    // MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = self.view.frame.origin.x
        screenHeight = self.view.frame.origin.y
        setCollectionViewLayout(collectionView: collectionView, itemWidth: 182, itemHeight: 158)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let webApiUrl = generateApiUrl(usingCategoryId: 0, andCountryID: 1)
        self.performDataFetch(webApiUrl: webApiUrl)
    }

    // MARK: IBActions
    @IBAction func languageButtonPressed(_ sender: Any) {
        if languageButton.currentTitle == "عربي" && isArabic == false  {
            languageButton.setTitle("English", for: UIControlState.normal)
            languageButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 17)
            isArabic = true
        } else if languageButton.currentTitle == "English" && isArabic == true {
            languageButton.setTitle("عربي", for: UIControlState.normal)
            languageButton.titleLabel?.font = UIFont(name: "GE Dinar One Medium", size: 17)
            isArabic = false
        }
        collectionView.reloadData()
    }
}

