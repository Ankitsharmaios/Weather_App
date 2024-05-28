//
//  DashChatsVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 23/05/24.
//

import UIKit
import FirebaseDatabase
import FirebaseDatabase
import FirebaseMessaging
import Firebase
import SDWebImage
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
    var ref: DatabaseReference!
    var LastChatData:[LiveChatDataModel]?
    var OptionNames:[String] = ["New group","New broadcast","Linked device","Starred message","Settings"]
  //  let dropDown = DropDown()
    class func getInstance()-> DashChatsVC {
        return DashChatsVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchFirebaseData()
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
        addbtnbgView.layer.cornerRadius = 10
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
            if LastChatData?.count ?? 0 > 0 {
                return LastChatData?.count ?? 0
            }else{
                return 0
            }
        }else if tableView == topTableView{
            return OptionNames.count
        }
      return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == chatTableView{
            if let cell = chatTableView .dequeueReusableCell(withIdentifier: "ChatsTBlvCell", for: indexPath) as? ChatsTBlvCell{
                cell.usernameLbl.text = LastChatData?[indexPath.row].senderName ?? ""
                cell.messageLbl.text = LastChatData?[indexPath.row].message ?? ""
                cell.timeLbl.text =  Converter.convertApiTimeToAMPM(apiTime: LastChatData?[indexPath.row].time ?? "")
                cell.timeLbl.textColor = appThemeColor.text_Weather
                cell.msgLeadingLayout.constant = 0
                cell.statusleadingLayout.constant = -2
                cell.ViewStatusImage.isHidden = true
                cell.msgCountLbl.text = LastChatData?[indexPath.row].unReadMessageCount ?? ""
//                let images = LastChatData?[indexPath.row]
//                cell.userImageView.sd_setImage(with: images?.receiverImage, placeholderImage: UIImage(named: "Place_Holder"))
                if let imageUrl2 = URL(string: LastChatData?[indexPath.row].senderImage ?? "") {
                    cell.userImageView?.sd_setImage(with: imageUrl2, placeholderImage: UIImage(named: "Place_Holder"))
//                    if userData.city == ""{
//                        locationImg.isHidden = true
//                    }else{
//                        locationImg.isHidden = false
//                    }
                }
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
            controller.UserName = LastChatData?[indexPath.row].senderName ?? ""
            self.present(controller, animated: true)
        }
        
        
        
        if tableView == topTableView {
            let selectedOption = OptionNames[indexPath.row]
            if selectedOption == "Settings" {
                DispatchQueue.main.async {
                    let twoStepVerificationVC = SettingsViewController.getInstance()
                    twoStepVerificationVC.modalPresentationStyle = .overCurrentContext
                    twoStepVerificationVC.showTabbar = {
                        self.showTabBar(animated: true)
                    }
                    self.hideTabBar(animated: true)
                    self.present(twoStepVerificationVC, animated: true)
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
    // MARK: FireBase Data Method LastChat
    func fetchFirebaseData() {
        ref = Database.database().reference()
        ref.getData { [self] error, snap in
            if let error = error {
                print("Error in fetching from firebase: \(error)")
                fetchFirebaseData()
            }else if ((snap?.exists()) != nil) {
                
                ref.child("\(firebaseTableName.LastChat)").observe(.value, with: { [self] (snapshot) in
                    //agoraArr1 = []
                    self.LastChatData = []
                    //                    for snap in snapshot.children {
                    //                        let userSnap = snap as! DataSnapshot
                    //                        _ = userSnap.key //the uid of each user
                    //                        let userDict = userSnap.value as! [String:AnyObject] //child data
                    
                    let uid = snapshot.key //the uid of each user
                   // let userDict = snapshot.value as! [String:AnyObject] //child data
                    for child in snapshot.children{
                        
                        let childSnap = child as! DataSnapshot
                        let userDict = childSnap.value as! [String: Any]
                        let date = userDict["date"] as? String
                        let id = userDict["id"] as? String
                        let indexId = userDict["indexId"] as? String
                        let isDeleted = userDict["isDeleted"] as? String
                        let message = userDict["message"] as? String
                        let messageStatus = userDict["messageStatus"] as? String
                        let receiverID = userDict["receiverID"] as? String
                        let receiverImage = userDict["receiverImage"] as? String
                        let receiverName = userDict["receiverName"] as? String
                        let receiverToken = userDict["receiverToken"] as? String
                        let senderFcmToken = userDict["senderFcmToken"] as? String
                        let senderImage = userDict["senderImage"] as? String
                        let senderName = userDict["senderName"] as? String
                        let sentID = userDict["sentID"] as? String
                        let time = userDict["time"] as? String
                        let videoCallLink = userDict["videoCallLink"] as? String
                        let videoCallStatus = userDict["videoCallStatus"] as? String
                        print("Ids-->",sentID,receiverID)
                        print("RegisterId",getString(key: userDefaultsKeys.RegisterId.rawValue))
                        if isDeleted?.lowercased() != "yes".lowercased(){
                        if sentID == getString(key: userDefaultsKeys.RegisterId.rawValue) || receiverID == getString(key: userDefaultsKeys.RegisterId.rawValue){
                            if let chatData = LiveChatDataModel(JSON: userDict) {
                                self.LastChatData?.append(chatData)
                                print("LastChat",LastChatData ?? [])
                            }
                        }
                    }
                        
                    }
                    self.chatTableView.reloadData()
                })
            }else {
                print("No data available")
            }
        }
    }
    
}
