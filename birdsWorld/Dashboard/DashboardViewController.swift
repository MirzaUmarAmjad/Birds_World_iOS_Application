//
//  DashboardViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 14/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import JGProgressHUD

class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var newAdsCollectionView: UICollectionView!
    @IBOutlet weak var AWLogin: UIActivityIndicatorView!
    
    
    let transiton = SlideInTransition()
    var topView: UIView?
    let hud = JGProgressHUD(style: .dark)
    

    let category = ["Lovebirds", "Budgerigars" , "Finches", "Java", "Exotic Birds", "Others"]
    var trending: JSON = []
    var newAds: JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        startActivity()
        API.homeDashboard(){ json, error in
            
            
            print(json)
            print(error)
            
            self.trending = json!["trending"]
            self.newAds = json!["new"]
            
            self.trendingCollectionView.reloadData()
            self.newAdsCollectionView.reloadData()
            self.stopActivity()
        
        }
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType) {

        topView?.removeFromSuperview()
        switch menuType {
        case .Home:
            
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case .Post_An_Ad:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "postUploadViewController") as! postUploadViewController
            nextViewContro‌​ller.title = "Post An Ad"
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
        case .All_Ads:
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
             nextViewContro‌​ller.titleText = "All Ads"
             self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
        case .Contact_Us:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            nextViewContro‌​ller.title = "Contact Us"
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollectionView {
            return trending.count
        }
        else if collectionView == newAdsCollectionView {
            return newAds.count
        }
        else{
            return category.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == CategoryCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
                       cell.categoryLabel.text = category[indexPath.item]
                       cell.cornerRadius = 10

                       return cell
        }
        else if collectionView == newAdsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newAdsCell", for: indexPath) as! NewAdsCollectionViewCell
            cell.newAdTitle.text = newAds[indexPath.item]["ads"]["title"].stringValue
            cell.newAdAmount.text = "RS:" + newAds[indexPath.item]["ads"]["price"].stringValue
           
            
            cell.newAdImage.sd_setImage(with: URL(string: API.imageURL + newAds[indexPath.item]["images"][0]["filename"].stringValue), placeholderImage: UIImage(named: "placeholder.png"))
            
         
            
            cell.cornerRadius = 10
                       
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendingCell", for: indexPath) as! TrendingCollectionViewCell
            cell.trendingTitle.text = trending[indexPath.item]["ads"]["title"].stringValue
            cell.trendingAmount.text = "RS:" + trending[indexPath.item]["ads"]["price"].stringValue
            
            
            cell.trendingImage.sd_setImage(with: URL(string: API.imageURL + trending[indexPath.item]["images"][0]["filename"].stringValue), placeholderImage: UIImage(named: "placeholder.png"))
                
           
            cell.cornerRadius = 10
                       
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        if collectionView == CategoryCollectionView {
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
             nextViewContro‌​ller.titleText = category[indexPath.item]
             self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
             print(indexPath.item)
        }
        else if collectionView == newAdsCollectionView {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DetailAdViewController") as! DetailAdViewController
            nextViewContro‌​ller.titleText = "Ad Detail"
            nextViewContro‌​ller.adId = newAds[indexPath.item]["ads"]["id"].stringValue
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
            
        }
        else{
//           print(trending[indexPath.item]["ads"]["id"].stringValue)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DetailAdViewController") as! DetailAdViewController
            nextViewContro‌​ller.titleText = "Ad Detail"
            nextViewContro‌​ller.adId = trending[indexPath.item]["ads"]["id"].stringValue
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
//            print(indexPath.item)
        }
            
        
    }
    
    func startActivity()
    {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        self.view.isUserInteractionEnabled = false
    }
    func stopActivity()
    {
        self.view.isUserInteractionEnabled = true
        hud.dismiss()
    }
    
}


extension DashboardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

