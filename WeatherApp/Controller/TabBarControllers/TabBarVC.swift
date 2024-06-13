////
////  TabBarVC.swift
////  WeatherApp
////
////  Created by Mahesh_MacMini on 23/05/24.
////
//
//import UIKit
//
//class TabBarVC: UITabBarController {
//    class func getInstance()-> TabBarVC {
//        return TabBarVC.viewController(storyboard: Constants.Storyboard.DashBoard)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if #available(iOS 15, *) {
//                   let tabBarAppearance = UITabBarAppearance()
//                   // tabBarAppearance.backgroundColor = backgroundColor
//                   
//                   // Set the title text attributes for normal and selected states
//                    let normalAttributes: [NSAttributedString.Key: Any] = [
//                        .foregroundColor: UIColor.black, // Set your desired color for unselected state
//                        .font: UIFont.systemFont(ofSize: 16)
//                    ]
//
//                    let selectedAttributes: [NSAttributedString.Key: Any] = [
//                        .foregroundColor: UIColor.black, // Set your desired color for selected state
//                        .font: UIFont.boldSystemFont(ofSize: 16)
//                    ]
//                   
//                   tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
//                   tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
//                   
//                   // Set the appearance for standard and scroll edge appearances
//                   tabBar.standardAppearance = tabBarAppearance
//                 
//            
//               
//               self.delegate = self
//               self.setValue(CustomTabBar(), forKey: "tabBar")
//               tabBar.tintColor = appThemeColor.CommonBlack
//               setupTabBarImages()
//           }
//    }
//    func setupTabBarImages() {
//           //First Tab
//           if let firstViewController = viewControllers?[0] {
//               firstViewController.tabBarItem.selectedImage = UIImage(named: "Group 277")?.withRenderingMode(.alwaysOriginal)
//               firstViewController.tabBarItem.image = UIImage(named: "Chat")?.withRenderingMode(.alwaysOriginal)
//               firstViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal) // Set unselected text color
//           }
//           // Second Tab
//           if let secondViewController = viewControllers?[1] {
//               secondViewController.tabBarItem.selectedImage = UIImage(named: "Group 278")?.withRenderingMode(.alwaysOriginal)
//               secondViewController.tabBarItem.image = UIImage(named: "Update")?.withRenderingMode(.alwaysOriginal)
//               secondViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//           }
//           // Notification VC
//           if let thirdViewController = viewControllers?[2] {
//               thirdViewController.tabBarItem.selectedImage = UIImage(named: "Group 279")?.withRenderingMode(.alwaysOriginal)
//               thirdViewController.tabBarItem.image = UIImage(named: "Commities")?.withRenderingMode(.alwaysOriginal)
//               thirdViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal) // Set unselected text color
//           }
//           // Menu VC
//           if let fourthViewController = viewControllers?[3] {
//               fourthViewController.tabBarItem.selectedImage = UIImage(named: "Group 273")?.withRenderingMode(.alwaysOriginal)
//               fourthViewController.tabBarItem.image = UIImage(named: "Call")?.withRenderingMode(.alwaysOriginal)
//               fourthViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//           }
//       }
//}
//extension TabBarVC: UITabBarControllerDelegate {
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        // This method is called when a tab bar item is selected
//        tabBar.tintColor = appThemeColor.CommonBlack // Set your desired color here
//        let tabBarAppearance = UITabBarAppearance()
//        // tabBarAppearance.backgroundColor = backgroundColor
//        
//        // Set the title text attributes for normal and selected states
//         let normalAttributes: [NSAttributedString.Key: Any] = [
//             .foregroundColor: UIColor.black, // Set your desired color for unselected state
//             .font: UIFont.systemFont(ofSize: 10)
//         ]
//
//         let selectedAttributes: [NSAttributedString.Key: Any] = [
//             .foregroundColor: UIColor.black, // Set your desired color for selected state
//             .font: UIFont.boldSystemFont(ofSize: 10)
//         ]
//        
//        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
//        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
//        
//        // Set the appearance for standard and scroll edge appearances
//        tabBar.standardAppearance = tabBarAppearance
//
//    }
//}
//class CustomTabBar: UITabBar {
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 85 // Set your desired height here
//        return sizeThatFits
//    }
//}
import UIKit

class TabBarVC: UITabBarController {
    class func getInstance()-> TabBarVC {
        return TabBarVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            // tabBarAppearance.backgroundColor = backgroundColor

            // Set the title text attributes for normal and selected states
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black, // Set your desired color for unselected state
                .font: UIFont.systemFont(ofSize: 16)
            ]

            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black, // Set your desired color for selected state
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]

            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

            // Set the appearance for standard and scroll edge appearances
            tabBar.standardAppearance = tabBarAppearance

            self.delegate = self
            self.setValue(CustomTabBar(), forKey: "tabBar")
            tabBar.tintColor = appThemeColor.CommonBlack
            setupTabBarImages()

            // Add the top border
            addTopBorderToTabBar()
        }
    }

    func setupTabBarImages() {
        // First Tab
        if let firstViewController = viewControllers?[0] {
            firstViewController.tabBarItem.selectedImage = UIImage(named: "Group 277")?.withRenderingMode(.alwaysOriginal)
            firstViewController.tabBarItem.image = UIImage(named: "Chat")?.withRenderingMode(.alwaysOriginal)
            firstViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal) // Set unselected text color
        }
        // Second Tab
        if let secondViewController = viewControllers?[1] {
            secondViewController.tabBarItem.selectedImage = UIImage(named: "Group 278")?.withRenderingMode(.alwaysOriginal)
            secondViewController.tabBarItem.image = UIImage(named: "Update")?.withRenderingMode(.alwaysOriginal)
            secondViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        }
        // Notification VC
        if let thirdViewController = viewControllers?[2] {
            thirdViewController.tabBarItem.selectedImage = UIImage(named: "Group 279")?.withRenderingMode(.alwaysOriginal)
            thirdViewController.tabBarItem.image = UIImage(named: "Commities")?.withRenderingMode(.alwaysOriginal)
            thirdViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal) // Set unselected text color
        }
        // Menu VC
        if let fourthViewController = viewControllers?[3] {
            fourthViewController.tabBarItem.selectedImage = UIImage(named: "Group 273")?.withRenderingMode(.alwaysOriginal)
            fourthViewController.tabBarItem.image = UIImage(named: "Call")?.withRenderingMode(.alwaysOriginal)
            fourthViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        }
    }

    private func addTopBorderToTabBar() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: -5, width: tabBar.frame.width, height: 0.5)
        borderLayer.backgroundColor = appThemeColor.btnLightGrey_BackGround.cgColor
        tabBar.layer.addSublayer(borderLayer)
    }
}

extension TabBarVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // This method is called when a tab bar item is selected
        tabBar.tintColor = appThemeColor.CommonBlack // Set your desired color here
        let tabBarAppearance = UITabBarAppearance()
        // tabBarAppearance.backgroundColor = backgroundColor

        // Set the title text attributes for normal and selected states
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // Set your desired color for unselected state
            .font: UIFont.systemFont(ofSize: 10)
        ]

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // Set your desired color for selected state
            .font: UIFont.boldSystemFont(ofSize: 10)
        ]

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

        // Set the appearance for standard and scroll edge appearances
        tabBar.standardAppearance = tabBarAppearance
    }
}

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 85 // Set your desired height here
        return sizeThatFits
    }
}
