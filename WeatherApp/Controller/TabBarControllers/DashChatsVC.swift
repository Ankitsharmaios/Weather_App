//
//  DashChatsVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 23/05/24.
//

import UIKit

class DashChatsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate & UITableViewDataSource & UITableViewDelegate{

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var toptableHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var toptablebgView: UIView!
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
    var isTopTableHide = false
    var OptionNames:[String] = ["New group","New broadcast","Linked device","Starred message","Settings"]
  //  let dropDown = DropDown()
    class func getInstance()-> DashChatsVC {
        return DashChatsVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.isHidden = true
        topTableView.isHidden = true

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.view.addGestureRecognizer(tapGesture)

        
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.topTableView.isHidden = true
    }
//    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//               // Get the tap location
//               let tapLocation = sender.location(in: self.view)
//
//               // Check if the tap is outside of myView's bounds
//               if !bgView.frame.contains(tapLocation) {
//                   // Dismiss myView or perform any action you want
//    //               bgView.removeFromSuperview()
//                   self.dismiss(animated: true)
//                   
//               }
//           }
    func setupUI(){
        topTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil),forCellReuseIdentifier: "optionHeaderTblvCell")
        chatTableView.register(UINib(nibName: "ChatsTBlvCell", bundle: nil),forCellReuseIdentifier: "ChatsTBlvCell")
         topTableView.dataSource = self
        topTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = .none
        toptableHeightLayout.constant = CGFloat(CGFloat((OptionNames.count)) * (40))
        topTableView.separatorStyle = .none
        topTableView.reloadData()
        topTableView.reloadData()
        weatherLbl.textColor = appThemeColor.text_Weather
        weatherLbl.font = Helvetica.helvetica_bold.font(size: 24)
        
        searchbgView.layer.cornerRadius = 20
        searchbgView.backgroundColor = appThemeColor.searchbgView
        addbtnbgView.backgroundColor = appThemeColor.text_Weather
        addbtnbgView.layer.cornerRadius = 13
        topTableView.layer.cornerRadius = 8
        topTableView.layer.masksToBounds = false
        topTableView.addShadowToTableView(view: topTableView, value: 2)
    }
    
    @IBAction func optionsBtn(_ sender: Any) {
        isTopTableHide.toggle()
        if isTopTableHide == true{
            self.topTableView.isHidden = false
        }else{
            self.topTableView.isHidden = true
        }
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
       openCamera()
    }
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
// MARK: TableView Methods
extension DashChatsVC{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == chatTableView{
            return 1
        }else if tableView == topTableView{
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == chatTableView{
            return 5
        }else if tableView == topTableView{
            return OptionNames.count
        }
      return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == chatTableView{
            if let cell = chatTableView .dequeueReusableCell(withIdentifier: "ChatsTBlvCell", for: indexPath) as? ChatsTBlvCell{
                return cell
            }
        }else if tableView == topTableView{
            if let cell = topTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
                cell.nameLbl.text = OptionNames[indexPath.row]
               
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == chatTableView{
            return 70
        }else if tableView == topTableView{
            return 43
        }
        return CGFloat()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if tableView == chatTableView {
            let controller = InnerChatVC.getInstance()
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: true)
        }
        
        
        
        if tableView == topTableView {
            let selectedOption = OptionNames[indexPath.row]
            if selectedOption == "Settings" {
                
                DispatchQueue.main.async {
                    let settingVC = SettingsViewController.getInstance()
                    settingVC.modalPresentationStyle = .overCurrentContext
                    settingVC.showTabbar = {
                        self.showTabBar(animated: true)
                    }
                    self.topTableView.isHidden = true
                    self.hideTabBar(animated: true)
                    self.present(settingVC, animated: true)
                }
            }
        }
    }
   
}
extension DashChatsVC
{
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
