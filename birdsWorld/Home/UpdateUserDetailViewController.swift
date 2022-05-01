//
//  UpdateUserDetailViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 01/05/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects

class UpdateUserDetailViewController: UIViewController {
    
    
    @IBOutlet weak var userName: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submit(_ sender: Any) {
        //create object
        let defaults = UserDefaults.standard
        
        
        
        API.adminUpdateDetail(name: userName.text!, id: defaults.string(forKey: Const.UserID)!, password: password.text!){ json, error in
            print(json)
            print(error)
            
            self.goToHome()
        }
    }
    
    func goToHome() {
            navigationController?.popViewController(animated: true)
    }
    
   
}
