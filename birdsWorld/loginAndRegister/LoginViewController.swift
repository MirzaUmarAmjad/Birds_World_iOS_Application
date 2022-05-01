//
//  LoginViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 14/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects
import JGProgressHUD

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    

    @IBAction func signup(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? UIViewController
        secondViewController?.modalPresentationStyle = .fullScreen
        self.present(secondViewController!, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        
        if email.text!.length == 0 {
            self.view.makeToast(message: "Enter Email" )
            return
        }
        
        if isValidEmailAddress(emailAddressString: email.text!) == false {
            self.view.makeToast(message: "Enter valid Email" )
            return
        }
        
        if password.text!.length == 0 {
            self.view.makeToast(message: "Enter Password" )
            return
        }
        
        startActivity()
        
        API.login(email: email.text!, password: password.text!){ json, error in
            print(json)
            print(error)
            
            if json == nil{
                self.stopActivity()
                self.view.makeToast(message: "Please try again." )
                return
            }
            else if json == "Incorrect"{
                self.stopActivity()
                self.view.makeToast(message: "Incorrect email or password" )
                return
            }
            else{
                let defaults = UserDefaults.standard
                defaults.set(json!["id"].stringValue, forKey: Const.UserID)
                self.stopActivity()
                self.gotoDashboard()
            }
        }
        
        
    }
    
    func gotoDashboard() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "DashboardViewControllerRoot") as! UINavigationController
        nextViewContro‌​ller.modalPresentationStyle = .fullScreen
        self.present(nextViewContro‌​ller, animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {

        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                returnValue = false
            }

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
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
