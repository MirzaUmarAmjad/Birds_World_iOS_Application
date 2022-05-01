//
//  postUploadViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 18/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit



class postUploadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Dashboard"
    }


}


