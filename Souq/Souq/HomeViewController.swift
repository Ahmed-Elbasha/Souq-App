//
//  HomeViewController.swift
//  Souq
//
//  Created by Ahmed Elbasha on 8/12/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
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

