//
//  DetailAdViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 16/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit


class DetailAdViewController: UIViewController {

    
    var adId = ""
    
    var titleText = ""
    var infos: DetailAdTableViewController!
    
    var adtitle = ""
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleText
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Connect",
            style: .plain,
            target: self,
            action: #selector(chatSayHi)
        )

        
        
    }
    
    @objc func chatSayHi() {
        
        API.adsListingSingle(id:adId){ json, error in
                            print(json)
        //                    print(error)
           
            
            
            self.adtitle = json!["ads"]["title"].stringValue
            self.userID = json!["ads"]["user_id"].stringValue
            
            //create object
            let defaults = UserDefaults.standard
            
            API.chatSayHi(from_id: defaults.string(forKey: Const.UserID)!, to_id: self.userID, body: "User want to connect with you for the ad with the title of \(self.adtitle)"){ json, error in
                
                print(json)
                print(error)
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ChatWebViewController") as! ChatWebViewController
                    self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
                    
                }
            
            
        }
      
    }
    

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the embedded PageViewController on load
    
        if let vc = segue.destination as? DetailAdTableViewController,
            segue.identifier == "DetailAdTableViewController" {
            self.infos = vc
            // if you already have your data object
            self.infos.adId1 = self.adId
        }

    }

}
