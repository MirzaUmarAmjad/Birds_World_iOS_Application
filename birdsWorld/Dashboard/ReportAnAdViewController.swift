//
//  ContactUsViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 18/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects

class ReportAnAdViewController: UIViewController {
    
    var adId = ""
    
    
    @IBOutlet weak var ReportTitle: HoshiTextField!
    @IBOutlet weak var reportDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reportDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.reportDescription.layer.borderWidth = 1
        
        // Hide Keyboard after tap is done
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func reportSubmit(_ sender: Any) {
        
        if ReportTitle.text!.length == 0 {
            self.view.makeToast(message: "Enter Title" )
            return
        }
        
        if reportDescription.text!.length == 0 {
            self.view.makeToast(message: "Enter Description" )
            return
        }
        
        startActivity()
        
        //create object
        let defaults = UserDefaults.standard
        
        API.reportAnAd(title: ReportTitle.text!, description: reportDescription.text , userId: defaults.string(forKey: Const.UserID)!, post_ad_id: adId){
                 json, error in
                 
                 print(json)
                 print(error)
            
            if json == nil{
                self.stopActivity()
                self.view.makeToast(message: "Please try again." )
                return
            }
            else{
                self.stopActivity()
              
                  // create the alert
                            let alert = UIAlertController(title: "Report", message: "post is submitted", preferredStyle: UIAlertController.Style.alert)

                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                                self.navigationController?.popViewController(animated: true)
                            } ))

                            // show the alert
                            self.present(alert, animated: true, completion: nil)
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
