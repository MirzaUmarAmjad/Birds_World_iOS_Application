//
//  ChatWebViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 19/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import WebKit

class ChatWebViewController: UIViewController, WKNavigationDelegate {

   
    @IBOutlet weak var webview: WKWebView!
    
    
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
        
        title = "message"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //create object
        let defaults = UserDefaults.standard

        //get value
        let id = defaults.string(forKey: Const.UserID)
        
        print(id)

        let url = URL(string: API.webViewUrl+"ioschatify/\(id!)")
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true


    }
    

}
