//
//  TabBarVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 23/05/24.
//

import UIKit

class TabBarVC: UITabBarController {
    class func getInstance()-> TabBarVC {
        return TabBarVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 15, *) {
//            let tabBarAppearance = UITabBarAppearance()
//        //    tabBarAppearance.backgroundColor = backgroundColor
//            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: appThemeColor.CommonBlack, .font: UIFont(name: "Helvetica", size: 15)]
//            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: appThemeColor.CommonBlack, .font: UIFont(name: "Helvetica", size: 15)]
//            tabBar.standardAppearance = tabBarAppearance
//            tabBar.scrollEdgeAppearance = tabBarAppearance
//        }
        if #available(iOS 15, *) {
                   let tabBarAppearance = UITabBarAppearance()
                   // tabBarAppearance.backgroundColor = backgroundColor
                   
                   // Set the title text attributes for normal and selected states
                   let normalAttributes = [
                       NSAttributedString.Key.foregroundColor: appThemeColor.CommonBlack,
                       NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!
                   ]
                   
                   let selectedAttributes = [
                       NSAttributedString.Key.foregroundColor: appThemeColor.CommonBlack,
                       NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)!
                   ]
                   
                   tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
                   tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
                   
                   // Set the appearance for standard and scroll edge appearances
                   tabBar.standardAppearance = tabBarAppearance
                   tabBar.scrollEdgeAppearance = tabBarAppearance
             //  }
               
               self.delegate = self
               self.setValue(CustomTabBar(), forKey: "tabBar")
               tabBar.tintColor = appThemeColor.CommonBlack
               setupTabBarImages()
           }
//        self.delegate = self
//        self.setValue(CustomTabBar(), forKey: "tabBar")
//               tabBar.tintColor = appThemeColor.CommonBlack
//               setupTabBarImages()
    }
    func setupTabBarImages() {
           //First Tab
           if let firstViewController = viewControllers?[0] {
               firstViewController.tabBarItem.selectedImage = UIImage(named: "Group 277")?.withRenderingMode(.alwaysOriginal)
               firstViewController.tabBarItem.image = UIImage(named: "Chat")?.withRenderingMode(.alwaysOriginal)
           }
           // Second Tab
           if let secondViewController = viewControllers?[1] {
               secondViewController.tabBarItem.selectedImage = UIImage(named: "Group 278")?.withRenderingMode(.alwaysOriginal)
               secondViewController.tabBarItem.image = UIImage(named: "Update")?.withRenderingMode(.alwaysOriginal)
           }
           // Notification VC
           if let thirdViewController = viewControllers?[2] {
               thirdViewController.tabBarItem.selectedImage = UIImage(named: "Group 279")?.withRenderingMode(.alwaysOriginal)
               thirdViewController.tabBarItem.image = UIImage(named: "Commities")?.withRenderingMode(.alwaysOriginal)
           }
           // Menu VC
           if let fourthViewController = viewControllers?[3] {
               fourthViewController.tabBarItem.selectedImage = UIImage(named: "Group 273")?.withRenderingMode(.alwaysOriginal)
               fourthViewController.tabBarItem.image = UIImage(named: "Call")?.withRenderingMode(.alwaysOriginal)
           }
       }
}
extension TabBarVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // This method is called when a tab bar item is selected
        tabBar.tintColor = appThemeColor.CommonBlack // Set your desired color here
    }
}
class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 85 // Set your desired height here
        return sizeThatFits
    }
}
