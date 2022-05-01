//
//  ViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 14/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginIn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController
        secondViewController?.modalPresentationStyle = .fullScreen
        self.present(secondViewController!, animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? UIViewController
        secondViewController?.modalPresentationStyle = .fullScreen
        self.present(secondViewController!, animated: true, completion: nil)
    }
    

}

