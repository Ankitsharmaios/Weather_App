//
//  CallsVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 17/06/24.
//

import UIKit

class CallsVC: UIViewController {

    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnAddcallContact: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblToStartcalling: UILabel!
    @IBOutlet weak var lblCalls: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        tableview.isHidden = true
    }
    

    func setUpUI()
    {
        lblCalls.font = Nunitonsans.nuniton_regular.font(size: 22)
        lblCalls.textColor = appThemeColor.CommonBlack
        
        lblToStartcalling.font = Helvetica.helvetica_regular.font(size: 15)
        lblToStartcalling.textColor = appThemeColor.text_LightColure
    }
    @IBAction func searchAction(_ sender: Any)
    {
        
    }
    @IBAction func moreOptionAction(_ sender: Any) 
    {
        
    }
    
    @IBAction func addcallAndContactAction(_ sender: Any) 
    {
        DispatchQueue.main.async {
            let ContactVc = ContactsViewController.getInstance()
            ContactVc.modalPresentationStyle = .overCurrentContext
            ContactVc.isfrom = "Calls"
            ContactVc.stackViewHideShow.isHidden = false
           
            ContactVc.stackviewHeightlayout.constant = 60
            ContactVc.newGroupHideShowView.isHidden = true
            ContactVc.view.layoutIfNeeded()
            ContactVc.updateHeaderViewHeight(newHeight: 90)
            
            ContactVc.showTabbar = {
                self.showTabBar(animated: true)
            }
            
            self.hideTabBar(animated: true)
            self.present(ContactVc, animated: true)
        }
    }
    func hideTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            _ = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height
            }
        }
    }
    
    func showTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            let tabBarHeight = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height - tabBarHeight
            }
        }
    }
}
