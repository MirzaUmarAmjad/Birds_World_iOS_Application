//
//  RegisterViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 14/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name: HoshiTextField!
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signin(_ sender: Any) {
        gotoSignIn()
    }
    
    @IBAction func signup(_ sender: Any) {
        
        if name.text!.length == 0 {
            self.view.makeToast(message: "Enter Name" )
            return
        }
        
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
        
        API.register(name: name.text!, email: email.text!, password: password.text!){ json, error in
            print(json)
            print(error)
            
            if json == nil{
                self.stopActivity()
                self.view.makeToast(message: "Please try again." )
                return
            }
            else{
                self.stopActivity()
                self.gotoSignIn()
            }
        }
    }
    
    func gotoSignIn() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController
        secondViewController?.modalPresentationStyle = .fullScreen
        self.present(secondViewController!, animated: true, completion: nil)
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
        view.makeToastActivity()
    }
    
    func stopActivity()
    {
        view.hideToastActivity()
    }
    
}
