//
//  BirdDetailTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 22/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import MaterialComponents.MaterialActionSheet

class BirdDetailTableViewController: UITableViewController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    var adId1 = ""
    var getringNumber = ""
    var getmutation = ""
    var getsplit = ""
    var getgender = ""
    var getcategory = ""
    var getdob = ""
    
    @IBOutlet weak var imageSlide: ImageSlideshow!
    @IBOutlet weak var ringNo: UILabel!
    @IBOutlet weak var mutation: UILabel!
    @IBOutlet weak var split: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: UIImage(named: "green-square-Retina"), style: .done, target: self, action: nil)
        
        let doneButtonAsLeftArrow = UIBarButtonItem(image: UIImage(named: "icons-menu-vertical.png"), style: .plain, target: self, action: #selector(showActionSheet))
        navigationItem.rightBarButtonItem = doneButtonAsLeftArrow
        
        
        imageSlide.slideshowInterval = 3.0
        imageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        imageSlide.pageIndicator = pageControl
        

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlide.addGestureRecognizer(recognizer)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apiFunctioncall()
    }
    
    
    func apiFunctioncall() {
        API.birdListingSingle(id:adId1){ json, error in
                            print(json)
        //                    print(error)
            
            self.getringNumber = json!["bird"]["ring_number"].stringValue
            self.getmutation = json!["bird"]["mutation"].stringValue
            self.getsplit = json!["bird"]["split"].stringValue
            self.getgender = json!["bird"]["gender"].stringValue
            self.getcategory = json!["bird"]["category"].stringValue
            self.getdob = json!["bird"]["dob"].stringValue
            
            self.ringNo.text = "Ring no: " + json!["bird"]["ring_number"].stringValue
            self.mutation.text = "Mutation: " + json!["bird"]["mutation"].stringValue
            self.split.text = "Split: " + json!["bird"]["split"].stringValue
            self.gender.text = "Gender: " + json!["bird"]["gender"].stringValue
            self.category.text = "Category: " + json!["bird"]["category"].stringValue
            self.dob.text = "Dob: " + json!["bird"]["dob"].stringValue
           
            
            
            //set image
            var imagesli = [ImageSource]()
            for (key, value) in json!["images"] {
                imagesli.append(ImageSource(image: API.getImage(imageFileName: value["filename"].stringValue )))

            }
            self.imageSlide.setImageInputs(imagesli)
            
            
        }
    }
    
    @objc func showActionSheet() {

           let actionSheet = MDCActionSheetController(title: "Birds Options",
                                                      message: "Select an option:")
           let actionOne = MDCActionSheetAction(title: "Edit",
                                                image: UIImage(named: "Home"),
                                                handler: {handler in
                                                    self.goToEdit()
           })
            let actionTwo = MDCActionSheetAction(title: "Delete",
                                                 image: UIImage(named: "Home"),
                                                 handler: {handler in
                                                     self.deleteBird()
            })
        
            actionSheet.addAction(actionOne)
            actionSheet.addAction(actionTwo)

           present(actionSheet, animated: true, completion: nil)
    }
    
    func goToEdit() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "AddBirdViewController") as! AddBirdViewController
        nextViewContro‌​ller.titleText = "Edit Bird Info"
        nextViewContro‌​ller.getringNumber = getringNumber
        nextViewContro‌​ller.getmutation = getmutation
        nextViewContro‌​ller.getsplit = getsplit
        nextViewContro‌​ller.getgender = getgender
        nextViewContro‌​ller.getcategory = getcategory
        nextViewContro‌​ller.getdob = getdob
        nextViewContro‌​ller.birdId = adId1
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func deleteBird() {
        
        startActivity()
        API.deleteBird(id: adId1){ json, error in
            print(json)
            print(error)
            
            self.stopActivity()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func didTap() {
        let fullScreenController = imageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
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
