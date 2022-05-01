//
//  ViewInbreedingClutchListTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 24/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MaterialActionSheet


class ViewInbreedingClutchListTableViewController: UITableViewController,  UISearchResultsUpdating {

    var tableData = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var titleText = ""
    var birdsDetail = JSON()
    var category = String()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            let doneButtonAsLeftArrow = UIBarButtonItem(image: UIImage(named: "icons-menu-vertical.png"), style: .plain, target: self, action: #selector(showActionSheet))
//            navigationItem.rightBarButtonItem = doneButtonAsLeftArrow
            
            //set title
            title = titleText

            //table view search
           resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()

                tableView.tableHeaderView = controller.searchBar

                return controller
            })()
            
            
            
            
            
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            //run api and reload api
            tableData = []
            loadApiType()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.backItem?.title = "Home"
        }

       override func numberOfSections(in tableView: UITableView) -> Int {
           // 1
           // return the number of sections
           return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // 2
          // return the number of rows
          if  (resultSearchController.isActive) {
              return filteredTableData.count
          } else {
              return tableData.count
          }
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // 3
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel!.numberOfLines = 0
          if (resultSearchController.isActive) {
              cell.textLabel?.text = filteredTableData[indexPath.row]

              return cell
          }
          else {
              cell.textLabel?.text = tableData[indexPath.row]
              print(tableData[indexPath.row])
              return cell
          }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)

            let sample = storyBoard.instantiateViewController(withIdentifier: "InBreedingClutchDetailTableViewController") as! InBreedingClutchDetailTableViewController
            
            sample.maleId = birdsDetail[indexPath.row]["male"]["id"].stringValue
            sample.femaleId = birdsDetail[indexPath.row]["female"]["id"].stringValue
            sample.pairId = birdsDetail[indexPath.row]["pair"]["id"].stringValue
            sample.cageNo = birdsDetail[indexPath.row]["pair"]["cage_no"].stringValue
            sample.totalEggs = birdsDetail[indexPath.row]["clutchInbreeding"]["total_eggs"].stringValue
            sample.totalChicks = birdsDetail[indexPath.row]["clutchInbreeding"]["total_chicks"].stringValue
            sample.eggLayingStartDate = birdsDetail[indexPath.row]["clutchInbreeding"]["egg_laying_start_date"].stringValue
            sample.clutchId = birdsDetail[indexPath.row]["clutchInbreeding"]["id"].stringValue
            
            self.navigationController?.pushViewController(sample, animated: true)
        }
        
        
        
        func updateSearchResults(for searchController: UISearchController) {
            filteredTableData.removeAll(keepingCapacity: false)

            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
            let array = (tableData as NSArray).filtered(using: searchPredicate)
            filteredTableData = array as! [String]

            self.tableView.reloadData()
        }
        
        func loadApiType() {
            //create object
            let defaults = UserDefaults.standard
            
            if titleText == "Lovebird Inbreeding Clutch" {
                API.lovebirdInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                        var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                            "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                            "Cage:" + value["pair"]["cage_no"].stringValue
                    
                    self.tableData.append(value)
                    }
                // Reload the table
                self.tableView.reloadData()
                }
                self.category = "Lovebird"
            }
            else if titleText == "Budgerigar Inbreeding Clutch" {
                API.budgerigarInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                 self.birdsDetail = json!
                 for (_, value) in self.birdsDetail{
                          var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                                                    "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                                                    "Cage:" + value["pair"]["cage_no"].stringValue
                         self.tableData.append(value)
                     }
                 // Reload the table
                 self.tableView.reloadData()
                 }
                self.category = "Budgerigar"
             }
             else if titleText == "Finch Inbreeding Clutch" {
                API.finchInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                 self.birdsDetail = json!
                 for (_, value) in self.birdsDetail{
                          var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                                                    "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                                                    "Cage:" + value["pair"]["cage_no"].stringValue
                         self.tableData.append(value)
                     }
                 // Reload the table
                 self.tableView.reloadData()
                 }
                self.category = "Finch"
             }
             else if titleText == "Java Inbreeding Clutch" {
                API.javaInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                 self.birdsDetail = json!
                 for (_, value) in self.birdsDetail{
                          var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                                                    "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                                                    "Cage:" + value["pair"]["cage_no"].stringValue
                         self.tableData.append(value)
                     }
                 // Reload the table
                 self.tableView.reloadData()
                 }
                self.category = "Java"
             }
             else if titleText == "Exotic Inbreeding Clutch" {
                API.exoticInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                 self.birdsDetail = json!
                 for (_, value) in self.birdsDetail{
                          var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                                                    "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                                                    "Cage:" + value["pair"]["cage_no"].stringValue
                         self.tableData.append(value)
                     }
                 // Reload the table
                 self.tableView.reloadData()
                 }
                self.category = "Exotic Bird"
             }
             else if titleText == "Other Inbreeding Clutch" {
                API.otherInbreedingClutch(id: defaults.string(forKey: Const.UserID)!){ json, error in
                    print(json)
                 self.birdsDetail = json!
                 for (_, value) in self.birdsDetail{
                          var value = "Male:" + value["male"]["ring_number"].stringValue + " - " + value["male"]["mutation"].stringValue + "\n" +
                                                    "Female:" + value["female"]["ring_number"].stringValue + " - " + value["female"]["mutation"].stringValue + "\n" +
                                                    "Cage:" + value["pair"]["cage_no"].stringValue
                         self.tableData.append(value)
                     }
                 // Reload the table
                 self.tableView.reloadData()
                 }
                self.category = "Other"
             }
        }
    
    @objc func showActionSheet() {

               let actionSheet = MDCActionSheetController(title: "Pair Options",
                                                          message: "Select an option:")
               let actionOne = MDCActionSheetAction(title: "Add Pair",
                                                    image: UIImage(named: "Home"),
                                                    handler: {handler in
                                                        self.addPair()
               })
               actionSheet.addAction(actionOne)

               present(actionSheet, animated: true, completion: nil)
        }
        
        func addPair() {
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "AddPairViewController") as! AddPairViewController
            nextViewContro‌​ller.titleText = "Add Pair"
            nextViewContro‌​ller.category = category
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
        }

    }
