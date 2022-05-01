//
//  HomeMenuTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 20/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit

enum HomeMenuType: Int {
    case Home
    case Dashboard
    
    case Ad
    
    case Bird
    
    case Pair
    
    case inbreeding_Clutch
    
    case Completed_Clutch
    
    case Settings
}


class HomeMenuTableViewController: UITableViewController {
    
    var didTapMenuType: ((HomeMenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = HomeMenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }

}
