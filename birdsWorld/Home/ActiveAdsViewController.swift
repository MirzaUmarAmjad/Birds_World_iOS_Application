//
//  ActiveAdsViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 20/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import MaterialComponents.MaterialActionSheet


class ActiveAdsViewController: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var activeAdCollectionView: UICollectionView!
    
    var titleText = ""
    var ads: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = titleText
        
        loadApiType()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Home"
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! ActiveAdsCollectionViewCell

        cell.activeAdTitle.text = ads[indexPath.item]["ads"]["title"].stringValue
        cell.activeAdPrice.text = "RS:" + ads[indexPath.item]["ads"]["price"].stringValue
        cell.activeAdView.text = "Views: " + ads[indexPath.item]["ads"]["no_of_views"].stringValue
        
        cell.activeAdImage.sd_setImage(with: URL(string: API.imageURL + ads[indexPath.item]["images"][0]["filename"].stringValue), placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.cornerRadius = 10

        return cell

    }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DetailAdViewController") as! DetailAdViewController
//                nextViewContro‌​ller.titleText = "Ad Detail"
//                nextViewContro‌​ller.adId = ads[indexPath.item]["ads"]["id"].stringValue
//                self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
            
            showActionSheetAlert(id: indexPath.item)

        }
    
    
    func showActionSheetAlert(id:Int) {
        let actionSheet = MDCActionSheetController(title: "Ads Options",
                                                   message: "Select any option:")
        let actionOne = MDCActionSheetAction(title: "View Ad",
                                             image: nil,
                                             handler: { (_) in
                                                self.viewAd(id: id)
                                             })
        let actionTwo = MDCActionSheetAction(title: "Closed Ad",
                                             image: nil,
                                             handler: { (_) in
                                                self.closedAd(id: id)
                                             })
        let actionThree = MDCActionSheetAction(title: "Delete Ad",
                                            image: nil,
                                            handler: { (_) in
                                               self.deleteAd(id: id)
                                            })
       
        actionSheet.addAction(actionOne)
        if titleText == "Active Ads" {
        actionSheet.addAction(actionTwo)
        }
        actionSheet.addAction(actionThree)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func viewAd(id:Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DetailAdViewController") as! DetailAdViewController
        nextViewContro‌​ller.titleText = "Ad Detail"
        nextViewContro‌​ller.adId = ads[id]["ads"]["id"].stringValue
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func closedAd(id:Int) {
        
        startActivity()
        API.updateActiveAds(id: ads[id]["ads"]["id"].stringValue){ json, error in
            print(json)
            print(error)
            self.loadApiType()
            
            self.stopActivity()
        }
    }
    
    func deleteAd(id:Int) {
        
        startActivity()
        API.deleteActiveAndClosedAds(id: ads[id]["ads"]["id"].stringValue){ json, error in
            print(json)
            print(error)
            self.loadApiType()
            
            self.stopActivity()
        }
    }
    
    
     func loadApiType() {
        
        //create object
        let defaults = UserDefaults.standard
        
        
           if titleText == "Active Ads" {
            API.activeAds(id: defaults.string(forKey: Const.UserID)!){ json, error in
                print(json)
                print(error)
                
                print("apple")
                   self.ads = json!
//                if self.ads.count != 0 {
                   self.activeAdCollectionView.reloadData()
//                }
               }
           }
           else if titleText == "Closed Ads" {
            
            API.closedAds(id: defaults.string(forKey: Const.UserID)!){ json, error in
                    print(json)
                    print(error)
                    self.ads = json!
//                     if self.ads.count != 0 {
                        self.activeAdCollectionView.reloadData()
//                    }
                }
            }
       }
    
    
    func startActivity()
    {
        self.view.isUserInteractionEnabled = false
        view.makeToastActivity()
    }
    func stopActivity()
    {
        self.view.isUserInteractionEnabled = true
        view.hideToastActivity()
    }
    

   
}
