//
//  MenuViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 15/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case Dashboard
    case Home
    case Post_An_Ad
    case All_Ads
    case Contact_Us
}

class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
