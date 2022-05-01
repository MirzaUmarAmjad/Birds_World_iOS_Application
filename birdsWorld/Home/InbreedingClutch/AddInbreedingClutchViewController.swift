//
//  AddInbreedingClutchViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 23/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import iOSDropDown
import TextFieldEffects

class AddInbreedingClutchViewController: UIViewController {
    
    var titleText = ""
    var pairId = ""
    
    var firstEggDateToUpdate = ""
    var totalEggToUpdate = ""
    var totalChicksToUpdate = ""
    var clutchIDToUpdate = ""
    
    
    @IBOutlet weak var totalEggs: HoshiTextField!
    @IBOutlet weak var totalChicks: HoshiTextField!
    @IBOutlet weak var firstEggDate: UIDatePicker!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        
        firstEggDate.maximumDate = Date()
        title = titleText
        
        totalEggs.text = totalEggToUpdate
        totalChicks.text = totalChicksToUpdate
        if firstEggDateToUpdate != "" {
            print("umar:",getDate()!)
            firstEggDate.date = getDate()!
        }
        
    }
    
    
    
    
    
    @IBAction func addClutchSubmit(_ sender: Any) {
        let formatter = DateFormatter()
         formatter.dateStyle = .short
         let dobdate = formatter.string(from: firstEggDate.date)
         
        if totalEggs.text!.length == 0 {
            self.view.makeToast(message: "Enter Eggs" )
            return
        }
        
        
        startActivity()
       
        if titleText == "Edit Clutch Info" {
            API.editClutchSave(totalEggs: totalEggs.text!, totalChicks: totalChicks.text!, firstEggDate: dobdate, id: clutchIDToUpdate){
                json, error in
                
                if json == nil{
                    self.stopActivity()
                    self.view.makeToast(message: "Please try again." )
                    return
                }
                else{
                   
                    self.stopActivity()
                    self.navigationController?.popViewController(animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else{
            
            //create object
            let defaults = UserDefaults.standard
            
            API.addClutch(pairId:pairId,totalEggs:totalEggs.text!,totalChicks:totalChicks.text!,firstEggDate:dobdate,userId:defaults.string(forKey: Const.UserID)!)
             { json, error in
                
                if json == nil{
                    self.stopActivity()
                    self.view.makeToast(message: "Please try again." )
                    return
                }
                else{
                   
                    self.stopActivity()

//                 // create the alert
                 let alert = UIAlertController(title: "Clutch", message: "Clutch is Added", preferredStyle: UIAlertController.Style.alert)

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
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: firstEggDateToUpdate) // replace Date String
    }

}
