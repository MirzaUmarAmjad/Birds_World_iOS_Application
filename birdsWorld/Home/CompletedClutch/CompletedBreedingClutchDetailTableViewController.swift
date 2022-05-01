//
//  CompletedBreedingClutchDetailTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 28/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import MaterialComponents.MaterialActionSheet

class CompletedBreedingClutchDetailTableViewController: UITableViewController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    var maleId = ""
    var femaleId = ""
    var pairId = ""
    
    var cageNo = ""
    var totalEggs = ""
    var totalChicks = ""
    var eggLayingStartDate = ""
    var clutchId = ""
//    var getringNumber = ""
//    var getmutation = ""
//    var getsplit = ""
//    var getgender = ""
//    var getcategory = ""
//    var getdob = ""
    
    
    
    
    @IBOutlet weak var detailCageNo: UILabel!
    @IBOutlet weak var detailTotalEggs: UILabel!
    @IBOutlet weak var detailEggLayingStartDate: UILabel!
    @IBOutlet weak var detailTotalChicks: UILabel!
    
    
    
    
    @IBOutlet weak var maleImageSlide: ImageSlideshow!
    @IBOutlet weak var maleRingNo: UILabel!
    @IBOutlet weak var maleMutation: UILabel!
    @IBOutlet weak var maleSplit: UILabel!
    @IBOutlet weak var maleGender: UILabel!
    @IBOutlet weak var maleCategory: UILabel!
    @IBOutlet weak var maleDob: UILabel!
    
    
    @IBOutlet weak var femaleImageSlide: ImageSlideshow!
    @IBOutlet weak var femaleRingNo: UILabel!
    @IBOutlet weak var femaleMutation: UILabel!
    @IBOutlet weak var femaleSplit: UILabel!
    @IBOutlet weak var femaleGender: UILabel!
    @IBOutlet weak var femaleCategory: UILabel!
    @IBOutlet weak var femaleDob: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButtonAsLeftArrow = UIBarButtonItem(image: UIImage(named: "icons-menu-vertical.png"), style: .plain, target: self, action: #selector(showActionSheet))
        navigationItem.rightBarButtonItem = doneButtonAsLeftArrow
        
        //inbreeding detail
        detailCageNo.text = "Cage No: " + cageNo
        detailTotalEggs.text = "Total Eggs: " + totalEggs
        detailEggLayingStartDate.text = "Egg Laying Start Date: " + eggLayingStartDate
        detailTotalChicks.text = "Total Chicks: " + totalChicks
        
        //male image slide
        maleImageSlide.slideshowInterval = 3.0
        maleImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        maleImageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        //female image slide
        femaleImageSlide.slideshowInterval = 3.0
        femaleImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        femaleImageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        maleImageSlide.pageIndicator = pageControl
        femaleImageSlide.pageIndicator = pageControl
        

        let maleRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMaleImage))
        maleImageSlide.addGestureRecognizer(maleRecognizer)
        let femaleRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFemaleImage))
        femaleImageSlide.addGestureRecognizer(femaleRecognizer)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apiFunctioncall()
    }
    
    
    func apiFunctioncall() {
        API.birdListingSingle(id:maleId){ json, error in
                            print(json)
        //                    print(error)
            
//            self.getringNumber = json!["bird"]["ring_number"].stringValue
//            self.getmutation = json!["bird"]["mutation"].stringValue
//            self.getsplit = json!["bird"]["split"].stringValue
//            self.getgender = json!["bird"]["gender"].stringValue
//            self.getcategory = json!["bird"]["category"].stringValue
//            self.getdob = json!["bird"]["dob"].stringValue
            
            self.maleRingNo.text = "Ring no: " + json!["bird"]["ring_number"].stringValue
            self.maleMutation.text = "Mutation: " + json!["bird"]["mutation"].stringValue
            self.maleSplit.text = "Split: " + json!["bird"]["split"].stringValue
            self.maleGender.text = "Gender: " + json!["bird"]["gender"].stringValue
            self.maleCategory.text = "Category: " + json!["bird"]["category"].stringValue
            self.maleDob.text = "Dob: " + json!["bird"]["dob"].stringValue
           
            
            
            //set image
            var imagesli = [ImageSource]()
            for (key, value) in json!["images"] {
                imagesli.append(ImageSource(image: API.getImage(imageFileName: value["filename"].stringValue )))

            }
            self.maleImageSlide.setImageInputs(imagesli)
            
            
        }
        
        API.birdListingSingle(id:femaleId){ json, error in
                                    print(json)
                //                    print(error)
                    
        //            self.getringNumber = json!["bird"]["ring_number"].stringValue
        //            self.getmutation = json!["bird"]["mutation"].stringValue
        //            self.getsplit = json!["bird"]["split"].stringValue
        //            self.getgender = json!["bird"]["gender"].stringValue
        //            self.getcategory = json!["bird"]["category"].stringValue
        //            self.getdob = json!["bird"]["dob"].stringValue
                    
                    self.femaleRingNo.text = "Ring no: " + json!["bird"]["ring_number"].stringValue
                    self.femaleMutation.text = "Mutation: " + json!["bird"]["mutation"].stringValue
                    self.femaleSplit.text = "Split: " + json!["bird"]["split"].stringValue
                    self.femaleGender.text = "Gender: " + json!["bird"]["gender"].stringValue
                    self.femaleCategory.text = "Category: " + json!["bird"]["category"].stringValue
                    self.femaleDob.text = "Dob: " + json!["bird"]["dob"].stringValue
                   
                    
                    
                    //set image
                    var imagesli = [ImageSource]()
                    for (key, value) in json!["images"] {
                        imagesli.append(ImageSource(image: API.getImage(imageFileName: value["filename"].stringValue )))

                    }
                    self.femaleImageSlide.setImageInputs(imagesli)
                    
                    
                }
    }
    
    @objc func showActionSheet() {

           let actionSheet = MDCActionSheetController(title: "Pair Options",
                                                      message: "Select an option:")
           let actionOne = MDCActionSheetAction(title: "Delete Clutch",
                                                image: UIImage(named: "Home"),
                                                handler: {handler in
                                                    self.deleteClutch()
           })
           actionSheet.addAction(actionOne)

           present(actionSheet, animated: true, completion: nil)
    }
    
    func goToAddClutch() {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "AddInbreedingClutchViewController") as! AddInbreedingClutchViewController
        nextViewContro‌​ller.titleText = "Edit Bird Info"
        nextViewContro‌​ller.pairId = pairId
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    
    @objc func didTapMaleImage() {
        let fullScreenController = maleImageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    @objc func didTapFemaleImage() {
        let fullScreenController = femaleImageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    func deleteClutch() {
        
        startActivity()
        API.deleteClutch(id: clutchId){ json, error in
            print(json)
            print(error)
            
            self.stopActivity()
            
            self.navigationController?.popViewController(animated: true)
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
