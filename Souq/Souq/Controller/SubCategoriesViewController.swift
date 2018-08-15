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
    
    var categories = [Category]()
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
    
    @IBAction func languageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
