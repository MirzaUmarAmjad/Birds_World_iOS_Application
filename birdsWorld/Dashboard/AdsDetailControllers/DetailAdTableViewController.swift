//
//  DetailAdTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 16/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire

class DetailAdTableViewController: UITableViewController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    var adId1 = ""

    @IBOutlet weak var imageSlide: ImageSlideshow!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    @IBOutlet weak var adRingNo: UILabel!
    @IBOutlet weak var adMutation: UILabel!
    @IBOutlet weak var adSplit: UILabel!
    @IBOutlet weak var adParentMaleMutation: UILabel!
    @IBOutlet weak var adGender: UILabel!
    @IBOutlet weak var adAgeInMonths: UILabel!
    @IBOutlet weak var adCity: UILabel!
    @IBOutlet weak var adParentFemaleMutation: UILabel!
    @IBOutlet weak var adCategory: UILabel!
    @IBOutlet weak var adDescription: UITextView!
    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var adAddress: UILabel!
    @IBOutlet weak var adPhone: UILabel!
    @IBOutlet weak var adMemberSince: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageSlide.slideshowInterval = 3.0
        imageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        imageSlide.pageIndicator = pageControl
        

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlide.addGestureRecognizer(recognizer)
        
        //set data
        
        

        API.adsListingSingle(id:adId1){ json, error in
                            print(json)
        //                    print(error)
           
            
            
            self.adTitle.text = json!["ads"]["title"].stringValue
            
            self.adPrice.text = "RS: " + json!["ads"]["price"].stringValue
            self.adRingNo.text = "Ring Number: " + json!["ads"]["ring_number"].stringValue
            self.adMutation.text = "Mutation: " + json!["ads"]["mutation"].stringValue
            self.adSplit.text = "Split: " + json!["ads"]["split"].stringValue
            self.adParentMaleMutation.text = "Parent Male Mutation: " + json!["ads"]["parent_male_mutation"].stringValue
            self.adGender.text = "Gender: " + json!["ads"]["gender"].stringValue
            self.adAgeInMonths.text = "Age in months: " + json!["ads"]["age"].stringValue
            self.adCity.text = "City: " + json!["ads"]["city"].stringValue
            self.adParentFemaleMutation.text = "Parent Female Mutation:" + json!["ads"]["parent_female_mutation"].stringValue
            self.adCategory.text = "Category: " + json!["ads"]["category"].stringValue
            self.adDescription.text = json!["ads"]["description"].stringValue
            self.adName.text = "Name: " + json!["seller"]["name"].stringValue
            self.adAddress.text = "Address: " + json!["ads"]["address"].stringValue
            self.adPhone.text = "Phone: " + json!["ads"]["phone"].stringValue
            
            
            //set image
            var imagesli = [ImageSource]()
            for (key, value) in json!["images"] {
                imagesli.append(ImageSource(image: API.getImage(imageFileName: value["filename"].stringValue )))

            }
            self.imageSlide.setImageInputs(imagesli)
            
            
        }
        
        
    }
    
    @objc func didTap() {
           let fullScreenController = imageSlide.presentFullScreenController(from: self)
           // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
           fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
       }

    @IBAction func reportAnAd(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ReportAnAdViewController") as! ReportAnAdViewController
        nextViewContro‌​ller.title = "Report An Ad"
        nextViewContro‌​ller.adId = adId1
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
  
   

}
