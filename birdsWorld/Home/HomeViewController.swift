//
//  HomeViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 20/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActionSheet
import Charts

class HomeViewController:  UIViewController {

    @IBOutlet weak var totalBirdsLabel: UILabel!
    @IBOutlet weak var totalPairs: UILabel!
    @IBOutlet weak var totalInbreeding: UILabel!
    @IBOutlet weak var totalCompleted: UILabel!
    @IBOutlet weak var pieChartAds: PieChartView!
    
    
    
    
    let transiton = SlideInTransition()
    var topView: UIView?
    
    
    var players = [String]()
    var goals = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //create object
        let defaults = UserDefaults.standard
        
        
        API.adminhome(id: defaults.string(forKey: Const.UserID)!){ json, error in
            print(json)
            print(error)
            
            self.totalBirdsLabel.text = json!["totalBirds"].stringValue
            self.totalPairs.text = json!["totalPairs"].stringValue
            self.totalInbreeding.text = json!["totalClutchInbreeding"].stringValue
            self.totalCompleted.text = json!["totalClutchCompleted"].stringValue
            
            for (key, value) in json!["ads"] {
                self.players.append(value["title"].stringValue)
                self.goals.append(Int(value["no_of_views"].stringValue)!)
            }
            
            self.customizeChart(dataPoints: self.players, values: self.goals.map{ Double($0) })
        }
        
        
        
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
        
      pieChartAds.data = pieChartData
      pieChartAds.drawEntryLabelsEnabled = false
    
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
    
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "HomeMenuTableViewController") as? HomeMenuTableViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: HomeMenuType) {

        topView?.removeFromSuperview()
        switch menuType {
        case .Home:
            print("home")
        case .Dashboard:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case .Ad:
            adsOption()
        
        case .Bird:
            birdsOption()
            
        case .Pair:
            pairsOption()
            
        case .inbreeding_Clutch:
            inbreedingClutchOption()
            
        case .Completed_Clutch:
            completedClutchOption()
            
        case .Settings:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "UpdateUserDetailViewController") as! UpdateUserDetailViewController
//            nextViewContro‌​ller.titleText = "Settings"
            self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
            
        default:
            break
        }
    }
    
    func adsOption() {
        let actionSheet = MDCActionSheetController(title: "Ads",
                                                   message: "Select ads option:")
        let actionOne = MDCActionSheetAction(title: "Active Ads",
                                             image: UIImage(named: "Home"),
                                             handler: { handler in
                                                self.adsNextScreen(adType:"Active Ads")
        })
        let actionTwo = MDCActionSheetAction(title: "Closed Ads",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.adsNextScreen(adType:"Closed Ads")
        })
        actionSheet.addAction(actionOne)
        actionSheet.addAction(actionTwo)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func adsNextScreen(adType:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ActiveAdsViewController") as! ActiveAdsViewController
        nextViewContro‌​ller.titleText = adType
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func birdsOption() {
        let actionSheet = MDCActionSheetController(title: "Birds",
                                                          message: "Select birds option:")
        let actionOne = MDCActionSheetAction(title: "Add Bird",
                                            image: UIImage(named: "Home"),
                                            handler: { handler in
                                                self.addBirds()
               })
        let actionTwo = MDCActionSheetAction(title: "All Birds",
                                            image: UIImage(named: "Email"),
                                            handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"All Birds")
               })
        let actionThree = MDCActionSheetAction(title: "Lovebird",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Lovebirds")
        })
        let actionFour = MDCActionSheetAction(title: "Budgerigars",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Budgerigars")
        })
        let actionFive = MDCActionSheetAction(title: "Finches",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Finches")
        })
        let actionSix = MDCActionSheetAction(title: "Java",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Java")
        })
        let actionSeven = MDCActionSheetAction(title: "Exotic Birds",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Exotic Birds")
        })
        let actionEight = MDCActionSheetAction(title: "Others",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeBirdsNextScreen(birdType:"Others")
        })
        
        actionSheet.addAction(actionOne)
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        actionSheet.addAction(actionFour)
        actionSheet.addAction(actionFive)
        actionSheet.addAction(actionSix)
        actionSheet.addAction(actionSeven)
        actionSheet.addAction(actionEight)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func addBirds() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "AddBirdViewController") as! AddBirdViewController
        nextViewContro‌​ller.titleText = "Add Bird"
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func seeBirdsNextScreen(birdType:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ViewBirdsListTableViewController") as! ViewBirdsListTableViewController
        nextViewContro‌​ller.titleText = birdType
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func pairsOption() {
        let actionSheet = MDCActionSheetController(title: "Pairs",
                                                          message: "Select pairs option:")
      
        let actionTwo = MDCActionSheetAction(title: "Lovebird Pairs",
                                            image: UIImage(named: "Email"),
                                            handler: { handler in
                                                self.seePairsNextScreen(pairType:"Lovebird Pairs")
               })
        let actionThree = MDCActionSheetAction(title: "Budgerigar Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seePairsNextScreen(pairType:"Budgerigar Pairs")
        })
        let actionFour = MDCActionSheetAction(title: "Finch Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seePairsNextScreen(pairType:"Finch Pairs")
        })
        let actionFive = MDCActionSheetAction(title: "Java Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seePairsNextScreen(pairType:"Java Pairs")
        })
        let actionSix = MDCActionSheetAction(title: "Exotic Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seePairsNextScreen(pairType:"Exotic Pairs")
        })
        let actionSeven = MDCActionSheetAction(title: "Other Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seePairsNextScreen(pairType:"Other Pairs")
        })
        
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        actionSheet.addAction(actionFour)
        actionSheet.addAction(actionFive)
        actionSheet.addAction(actionSix)
        actionSheet.addAction(actionSeven)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func seePairsNextScreen(pairType:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ViewPairsListTableViewController") as! ViewPairsListTableViewController
        nextViewContro‌​ller.titleText = pairType
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func inbreedingClutchOption() {
        let actionSheet = MDCActionSheetController(title: "Inbreeding Clutch",
                                                          message: "Select inbreeding clutch option:")
      
        let actionTwo = MDCActionSheetAction(title: "Lovebird Pairs",
                                            image: UIImage(named: "Email"),
                                            handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Lovebird Inbreeding Clutch")
               })
        let actionThree = MDCActionSheetAction(title: "Budgerigar Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Budgerigar Inbreeding Clutch")
        })
        let actionFour = MDCActionSheetAction(title: "Finch Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Finch Inbreeding Clutch")
        })
        let actionFive = MDCActionSheetAction(title: "Java Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Java Inbreeding Clutch")
        })
        let actionSix = MDCActionSheetAction(title: "Exotic Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Exotic Inbreeding Clutch")
        })
        let actionSeven = MDCActionSheetAction(title: "Other Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seeinbreedingClutchNextScreen(inbreedingClutchType:"Other Inbreeding Clutch")
        })
        
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        actionSheet.addAction(actionFour)
        actionSheet.addAction(actionFive)
        actionSheet.addAction(actionSix)
        actionSheet.addAction(actionSeven)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func seeinbreedingClutchNextScreen(inbreedingClutchType:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ViewInbreedingClutchListTableViewController") as! ViewInbreedingClutchListTableViewController
        nextViewContro‌​ller.titleText = inbreedingClutchType
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }
    
    func completedClutchOption() {
        let actionSheet = MDCActionSheetController(title: "Inbreeding Clutch",
                                                          message: "Select inbreeding clutch option:")
      
        let actionTwo = MDCActionSheetAction(title: "Lovebird Pairs",
                                            image: UIImage(named: "Email"),
                                            handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Lovebird Completed Clutch")
               })
        let actionThree = MDCActionSheetAction(title: "Budgerigar Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Budgerigar Completed Clutch")
        })
        let actionFour = MDCActionSheetAction(title: "Finch Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Finch Completed Clutch")
        })
        let actionFive = MDCActionSheetAction(title: "Java Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Java Completed Clutch")
        })
        let actionSix = MDCActionSheetAction(title: "Exotic Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Exotic Completed Clutch")
        })
        let actionSeven = MDCActionSheetAction(title: "Other Pairs",
                                             image: UIImage(named: "Email"),
                                             handler: { handler in
                                                self.seecompletedClutchNextScreen(inbreedingClutchType:"Other Completed Clutch")
        })
        
        actionSheet.addAction(actionTwo)
        actionSheet.addAction(actionThree)
        actionSheet.addAction(actionFour)
        actionSheet.addAction(actionFive)
        actionSheet.addAction(actionSix)
        actionSheet.addAction(actionSeven)

        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func seecompletedClutchNextScreen(inbreedingClutchType:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewContro‌​ller = storyBoard.instantiateViewController(withIdentifier: "ViewCompletedClutchListTableViewController") as! ViewCompletedClutchListTableViewController
        nextViewContro‌​ller.titleText = inbreedingClutchType
        self.navigationController?.pushViewController(nextViewContro‌​ller, animated: true)
    }

}



extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
