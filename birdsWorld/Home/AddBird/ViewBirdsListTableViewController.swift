//
//  TestTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 21/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewBirdsListTableViewController: UITableViewController, UISearchResultsUpdating {

    var tableData = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var titleText = ""
    var birdsDetail = JSON()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        let sample = storyBoard.instantiateViewController(withIdentifier: "BirdDetailTableViewController") as! BirdDetailTableViewController
        
        sample.adId1 = birdsDetail[indexPath.row]["ads"]["id"].stringValue
        
        self.navigationController?.pushViewController(sample, animated: true)
        
//        print(birdsDetail[indexPath.row]["ads"]["id"].stringValue)
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
        
        
        if titleText == "Lovebirds" {
            API.lovebirds(id: defaults.string(forKey: Const.UserID)!){ json, error in
            self.birdsDetail = json!
            for (_, value) in self.birdsDetail{
                    var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                    self.tableData.append(value)
                }
            // Reload the table
            self.tableView.reloadData()
            }
        }
        else if titleText == "Budgerigars" {
            API.budgerigars(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                     var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                     self.tableData.append(value)
                 }
             // Reload the table
             self.tableView.reloadData()
             }
         }
         else if titleText == "Finches" {
            API.finches(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                     var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                     self.tableData.append(value)
                 }
             // Reload the table
             self.tableView.reloadData()
             }
         }
         else if titleText == "Java" {
            API.java(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                     var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                     self.tableData.append(value)
                 }
             // Reload the table
             self.tableView.reloadData()
             }
         }
         else if titleText == "Exotic Birds" {
            API.exoticBirds(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                     var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                     self.tableData.append(value)
                 }
             // Reload the table
             self.tableView.reloadData()
             }
         }
         else if titleText == "Others" {
            API.otherBirds(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                     var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                     self.tableData.append(value)
                 }
             // Reload the table
             self.tableView.reloadData()
             }
         }
         else {
            API.allBirds(id: defaults.string(forKey: Const.UserID)!){ json, error in
                self.birdsDetail = json!
                for (_, value) in self.birdsDetail{
                                 var value = value["ads"]["ring_number"].stringValue + " - " + value["ads"]["mutation"].stringValue
                                 self.tableData.append(value)
                             }
                         // Reload the table
                         self.tableView.reloadData()
                         }
         }
    }

}
