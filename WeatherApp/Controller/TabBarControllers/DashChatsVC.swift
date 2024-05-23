//
//  DashChatsVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 23/05/24.
//

import UIKit

class DashChatsVC: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addbtnbgView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchtxt: UITextField!
    @IBOutlet weak var searchbgView: UIView!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
  //  let dropDown = DropDown()
    class func getInstance()-> DashChatsVC {
        return DashChatsVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    func setupUI(){
//        dropDown.anchorView = optionsBtn // UIView or UIBarButtonItem
//
//        // The list of items to display. Can be changed dynamically
//        dropDown.dataSource = ["New group","New broadcast","Linked device","Starred message","Settings"]
//        dropDown.width = 200
        weatherLbl.textColor = appThemeColor.text_Weather
        weatherLbl.font = Helvetica.helvetica_bold.font(size: 24)
        searchbgView.layer.cornerRadius = 20
        searchbgView.backgroundColor = appThemeColor.searchbgView
        addbtnbgView.backgroundColor = appThemeColor.text_Weather
        addbtnbgView.layer.cornerRadius = 8
    }
    
    @IBAction func optionsBtn(_ sender: Any) {
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)")
//            dropDown.direction = .bottom
//            dropDown.show()
//        }
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
    }
}
