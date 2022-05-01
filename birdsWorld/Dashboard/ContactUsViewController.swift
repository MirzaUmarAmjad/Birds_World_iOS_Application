//
//  ContactUsViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 18/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var contactTitle: HoshiTextField!
    @IBOutlet weak var contactDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.contactDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.contactDescription.layer.borderWidth = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Dashboard"
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        
        if contactTitle.text!.length == 0 {
            self.view.makeToast(message: "Enter Title" )
            return
        }
        
        if contactDescription.text!.length == 0 {
            self.view.makeToast(message: "Enter Description" )
            return
        }
        
        startActivity()
        
        //create object
        let defaults = UserDefaults.standard
        
        API.contactUs(title: contactTitle.text!, description: contactDescription.text , userId: defaults.string(forKey: Const.UserID)!){
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
                       let alert = UIAlertController(title: "Contact", message: "post is submitted", preferredStyle: UIAlertController.Style.alert)

                       // add an action (button)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                           self.gotoDashboard()
                       } ))

                       // show the alert
                       self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func gotoDashboard() {
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
