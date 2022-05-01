//
//  AddBirdViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 21/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import iOSDropDown
import TextFieldEffects

class AddBirdViewController: UIViewController {
    
    var birdId = ""
    
    var titleText = ""
    let imagePicker = ImagePickerController()
    var selectedImage = [Data]()
    var getringNumber = ""
    var getmutation = ""
    var getsplit = ""
    var getgender = ""
    var getcategory = ""
    var getdob = ""
    
    @IBOutlet weak var ringNumber: HoshiTextField!
    @IBOutlet weak var mutation: HoshiTextField!
    @IBOutlet weak var split: HoshiTextField!
    @IBOutlet weak var gender: DropDown!
    @IBOutlet weak var category: DropDown!
    @IBOutlet weak var addBirdUploadImageLabel: UILabel!
    @IBOutlet weak var dob: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gender.optionArray = ["Not Know", "Male", "Female"]
        category.optionArray = ["Lovebird", "Budgerigar", "Finch", "Java", "Exotic Bird", "Other"]
        dob.maximumDate = Date()
        
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.largeTitleDisplayMode = .never
        
        
        if getdob != "" {
            dob.date = getDate()!
        }
        
        title = titleText
        ringNumber.text = getringNumber
        mutation.text = getmutation
        split.text = getsplit
        gender.text = getgender
        category.text = getcategory
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Home"
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: getdob) // replace Date String
    }

    
    @IBAction func addBirdUploadImageSubmit(_ sender: Any) {
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
            }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
            }, cancel: { (assets) in
            // User canceled selection.
            }, finish: { (assets) in

            let options = PHImageRequestOptions()
            options.isSynchronous = true

            for asset in assets{

                // Request the maximum size. If you only need a smaller size make sure to request that instead.
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
                // Do something with image
                let imgdata = image!.jpegData(compressionQuality: 0)
                self.selectedImage.append(imgdata!)
               //                    print()
                }
                }

                self.addBirdUploadImageLabel.text = "selected images: \(assets.count)"

                })
        
    }
    
    @IBAction func addBirdSubmit(_ sender: Any) {
        
        if ringNumber.text!.length == 0 {
            self.view.makeToast(message: "Enter Ring Number" )
            return
        }
        
        if mutation.text!.length == 0 {
            self.view.makeToast(message: "Enter mutation" )
            return
        }
        
        if gender.text!.length == 0 {
            self.view.makeToast(message: "Enter gender" )
            return
        }
        
        if category.text!.length == 0 {
            self.view.makeToast(message: "Enter category" )
            return
        }
        
        if selectedImage.count == 0 {
            self.view.makeToast(message: "Select Image" )
            return
        }
        
        startActivity()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dobdate = formatter.string(from: dob.date)
        if titleText == "Edit Bird Info" {
             API.editBirdSave(ringNumber: ringNumber.text!, mutation: mutation.text!, split: split.text!,bird_id: birdId ,gender: gender.text!, category: category.text!, dob: dobdate, photos: selectedImage)
                       { json, error in
                                  
                        if json == nil{
                            self.stopActivity()
                            self.view.makeToast(message: "Please try again." )
                            return
                        }
                        
                        else{
                            self.stopActivity()
                          
                       
                                  
                                  
                                  // create the alert
                                  let alert = UIAlertController(title: "Post", message: "Bird is updated", preferredStyle: UIAlertController.Style.alert)

                                  // add an action (button)
                                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                                      self.gotoHome()
                                  } ))

                                  // show the alert
                                  self.present(alert, animated: true, completion: nil)
                              }
                                  
                              }
            
        }
        else{
            //create object
            let defaults = UserDefaults.standard
            
            
            API.addBirdsuploadSubmit(ringNumber: ringNumber.text!, mutation: mutation.text!, split: split.text!, user_id: defaults.string(forKey: Const.UserID)!, gender: gender.text!, category: category.text!, dob: dobdate, photos: selectedImage)
            { json, error in
                       
                       if json == nil{
                           self.stopActivity()
                           self.view.makeToast(message: "Please try again." )
                           return
                       }
                       
                       else{
                           self.stopActivity()
                       
                       
                       // create the alert
                       let alert = UIAlertController(title: "Post", message: "Bird is submitted", preferredStyle: UIAlertController.Style.alert)

                       // add an action (button)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                           self.gotoHome()
                       } ))

                       // show the alert
                       self.present(alert, animated: true, completion: nil)
                       
                }
                       
                   }
        }
   
    }
    
    func gotoHome() {
         self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
