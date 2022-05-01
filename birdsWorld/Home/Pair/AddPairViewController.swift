//
//  AddPairViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 23/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import iOSDropDown
import TextFieldEffects

class AddPairViewController: UIViewController {
    
    var titleText = ""
    var category = ""
    
    var maleSelectedId = [Int]()
    var femaleSelectedId = [Int]()
    var maleSelected = Int()
    var femaleSelected = Int()
    
//    var maleId = ""
//    var femaleId = ""
//    var pairingDate = ""
//    var cageNo = ""
    
    
    @IBOutlet weak var male: DropDown!
    @IBOutlet weak var female: DropDown!
    @IBOutlet weak var cageNo: HoshiTextField!
    @IBOutlet weak var pairingDate: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        

        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        
        //create object
        let defaults = UserDefaults.standard
        
        
        API.createPair(userId: defaults.string(forKey: Const.UserID)!, category: category){ json, error in
       
            for (_, value) in json!["males"]{
                
                self.maleSelectedId.append(value["id"].int!)
                
                var value = value["ring_number"].stringValue + " - " + value["mutation"].stringValue
                
                self.male.optionArray.append(value)
                
            }
            
            for (_, value) in json!["females"]{
                
                self.femaleSelectedId.append(value["id"].int!)
                
                var value = value["ring_number"].stringValue + " - " + value["mutation"].stringValue
                
                self.female.optionArray.append(value)
                
            }
       
        }
        
        pairingDate.maximumDate = Date()
        title = titleText
        
        male.didSelect{(selectedText , index ,id) in
            self.maleSelected = self.maleSelectedId[index]
               }
               
               female.didSelect{(selectedText , index ,id) in
                self.femaleSelected = self.femaleSelectedId[index]
               }
        
    }
    
    
    @IBAction func addPairSubmit(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dobdate = formatter.string(from: pairingDate.date)
        
        
        
        if male.text!.length == 0 {
            self.view.makeToast(message: "Select Male" )
            return
        }
        
        if female.text!.length == 0 {
            self.view.makeToast(message: "Select Female" )
            return
        }
        
        if cageNo.text!.length == 0 {
            self.view.makeToast(message: "Enter Cage No" )
            return
        }
        
        startActivity()
       
        //create object
        let defaults = UserDefaults.standard
        
        
        API.addPair(maleId:String(maleSelected) ,femaleId:String(femaleSelected) ,pairingDate:dobdate,userId:defaults.string(forKey: Const.UserID)!,category:category,cageNo:cageNo.text!)
        { json, error in
            
            
            if json == nil{
                self.stopActivity()
                self.view.makeToast(message: "Please try again." )
                return
            }
            else{
                self.stopActivity()
            

            // create the alert
            let alert = UIAlertController(title: "Pair", message: "Pair is Added", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                self.gotoHome()
            } ))

            // show the alert
            self.present(alert, animated: true, completion: nil)
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
