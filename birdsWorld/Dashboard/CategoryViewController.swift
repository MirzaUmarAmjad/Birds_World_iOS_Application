//
//  CategoryViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 15/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class CategoryViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var adsCollectionView: UICollectionView!
    var titleText = ""
    var ads: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = titleText
        
        loadApiType()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Dashboard"
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! AllAdsCollectionViewCell

        cell.adlabel.text = ads[indexPath.item]["ads"]["title"].stringValue
        cell.adPrice.text = "RS:" + ads[indexPath.item]["ads"]["price"].stringValue
        
        cell.adImage.sd_setImage(with: URL(string: API.imageURL + ads[indexPath.item]["images"][0]["filename"].stringValue), placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.cornerRadius = 10

        return cell

    }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DetailAdViewController") as! DetailAdViewController
                nextViewContro‌​ller.titleText = "Ad Detail"
                nextViewContro‌​ller.adId = ads[indexPath.item]["ads"]["id"].stringValue
                self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)

        }
    
    
     func loadApiType() {
           if titleText == "Lovebirds" {
               API.LovebirdAllAds(){ json, error in
                   self.ads = json!
                if self.ads.count != 0 {
                   self.adsCollectionView.reloadData()
                }
               }
           }
           else if titleText == "Budgerigars" {
                API.budgerigarsAllAds(){ json, error in
                    self.ads = json!
                     if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
            else if titleText == "Finches" {
                API.finchAllAds(){ json, error in
                    self.ads = json!
                    if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
            else if titleText == "Java" {
                API.javaAllAds(){ json, error in
                    self.ads = json!
                    if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
            else if titleText == "Exotic Birds" {
                API.exoticBirdAllAds(){ json, error in
                    self.ads = json!
                    if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
            else if titleText == "Others" {
                API.otherAllAds(){ json, error in
                    self.ads = json!
                    if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
            else {
                API.allAds(){ json, error in
                    self.ads = json!
                    if self.ads.count != 0 {
                        self.adsCollectionView.reloadData()
                    }
                }
            }
       }

}
