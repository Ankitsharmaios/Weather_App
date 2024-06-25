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

    @IBOutlet weak var footerLblYourPersonal: UILabel!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var btnAddChat: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
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
    var AppConfigData:AppConfigModel?
    var showTabbar: (() -> Void )?
    var ref: DatabaseReference!
    var LastChatData:[LiveChatDataModel]?
    var OptionNames:[String] = ["New group","New broadcast","Linked device","Starred message","Settings"]
  //  let dropDown = DropDown()
    class func getInstance()-> DashChatsVC {
        return DashChatsVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCityWeatherData()
        setupUI()
       
        fetchFirebaseData()
        navigationController?.navigationBar.isHidden = true
    
        tabBarController?.tabBar.barTintColor = appThemeColor.CommonBlack
    
    }
    
    
    func setupUI() {
            chatTableView.register(UINib(nibName: "ChatsTBlvCell", bundle: nil), forCellReuseIdentifier: "ChatsTBlvCell")
            chatTableView.register(UINib(nibName: "FooterViewTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterViewTableViewCell")
            chatTableView.dataSource = self
            chatTableView.delegate = self
            chatTableView.separatorStyle = .none
            weatherLbl.font = Helvetica.helvetica_bold.font(size: 24)
            searchbgView.layer.cornerRadius = 20
            searchbgView.backgroundColor = appThemeColor.searchbgView
            addbtnbgView.backgroundColor = appThemeColor.text_Weather
            addbtnbgView.layer.cornerRadius = 13
        }
   
    @IBAction func optionsBtn(_ sender: Any) {
        DispatchQueue.main.async {
            let ContactVc = SettingsViewController.getInstance()
            ContactVc.modalPresentationStyle = .overCurrentContext
            ContactVc.showTabbar = {
                self.showTabBar(animated: true)
            }
           
            self.hideTabBar(animated: true)
            self.present(ContactVc, animated: true)
        }
    }
    
    @IBAction func addChatAction(_ sender: Any)
    {
        DispatchQueue.main.async {
            let ContactVc = ContactsViewController.getInstance()
            ContactVc.modalPresentationStyle = .overCurrentContext
            ContactVc.showTabbar = {
                self.showTabBar(animated: true)
                self.fetchFirebaseData()
            }
           
            self.hideTabBar(animated: true)
            self.present(ContactVc, animated: true)
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
           return 2
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0:
               return LastChatData?.count ?? 0
           case 1:
               return 1 // Footer view cell
           default:
               return 0
           }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if indexPath.section == 0 {
               // Section 0: Chat cells
               if let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatsTBlvCell", for: indexPath) as? ChatsTBlvCell {
                   if let chatData = LastChatData?[indexPath.row] {
                       cell.usernameLbl.text = chatData.senderName ?? ""
                       cell.messageLbl.text = chatData.message ?? ""
                       cell.timeLbl.text = Converter.convertApiTimeToAMPM(apiTime: chatData.time ?? "")
                       cell.timeLbl.textColor = appThemeColor.text_Weather
                       cell.msgLeadingLayout.constant = -13
                       
                       if let unReadCountString = chatData.unReadMessageCount,
                          let unReadCount = Int(unReadCountString) {
                           if unReadCount > 0 {
                               cell.msgCountLbl.text = "\(unReadCount)"
                           } else {
                               cell.msgCountLbl.isHidden = true
                           }
                       } else {
                           cell.msgCountLbl.isHidden = true
                       }
                       
                       // Assuming ViewStatusImage and userImageView setup as per your cell design
                       cell.ViewStatusImage.isHidden = true
                       if let imageUrl = URL(string: chatData.senderImage ?? "") {
                           cell.userImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Place_Holder"))
                       }
                   }
                   return cell
               }
           } else if indexPath.section == 1 {
               // Section 1: Footer view cell
               if let cell = chatTableView.dequeueReusableCell(withIdentifier: "FooterViewTableViewCell", for: indexPath) as? FooterViewTableViewCell {
                   // Configure your footer cell here if needed
                   return cell
               }
           }
           
           // Return a default cell if none matched
           return UITableViewCell()
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if indexPath.section == 1 {
               // Adjust height for your footer view cell if needed
               return 50
           }
           return UITableView.automaticDimension // Default height for chat cells
       }
       
       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           // Return nil for section 0 to avoid any footer view there
           if section == 1 {
               // Provide a custom footer view if needed
               let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
               footerView.backgroundColor = .clear
               // Add any subviews or configure as needed
               return footerView
           }
           return nil
       }
       
       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           // Return height for footer view in section 1
           if section == 1 {
               return 50
           }
           return CGFloat.leastNonzeroMagnitude // Hide footer for section 0
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            let controller = InnerChatVC.getInstance()
            controller.modalPresentationStyle = .overFullScreen
            controller.UserName = LastChatData?[indexPath.row].senderName ?? ""
            if let selectedChat = LastChatData?[indexPath.row] {
                
                controller.LastChatData = selectedChat
                
            }
            
            self.present(controller, animated: true)
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
                } else if ((snap?.exists()) != nil) {
                    ref.child("\(firebaseTableName.LastChat)").observe(.value, with: { [self] (snapshot) in
                        self.LastChatData = []
                        var firebaseIdsArray: [String] = [] // Array to store Firebase IDs
                        
                        for child in snapshot.children {
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
                            
                            print("Ids-->", sentID, receiverID)
                            // Store the Firebase ID in the array
                            firebaseIdsArray.append(id ?? "")
                           
                            
                            if isDeleted?.lowercased() != "yes".lowercased() {
                                if receiverID == getString(key: userDefaultsKeys.RegisterId.rawValue) || sentID == getString(key: userDefaultsKeys.RegisterId.rawValue){
                                    if let chatData = LiveChatDataModel(JSON: userDict) {
                                        self.LastChatData?.append(chatData)
                                        print("LastChat", LastChatData ?? [])
                                        self.chatTableView.reloadData()
                                        
                                        
                                    }
                                }
                            }
                        }
                        
                        // Assign the array of Firebase IDs to the singleton
                        Singleton.sharedInstance.firebaseIdsArray = firebaseIdsArray
                        print("=====>",Singleton.sharedInstance.firebaseIdsArray)
                    })
                } else {
                    print("No data available")
                }
            }
        }
 
}
   

extension DashChatsVC
{
    
    // MARK: Call Api
    func getCityWeatherData() {
   
        let params = ["RegisterId":getString(key: userDefaultsKeys.RegisterId.rawValue),
        ]
        DataManager.shared.AppConfig(params: params, isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let appConfig):
                print("AppConfigData", appConfig)
                self?.AppConfigData = appConfig
                
                if self?.AppConfigData?.statusMessage?.lowercased() == "app configuration list".lowercased() || self?.AppConfigData?.status == true {
                    self?.weatherLbl.text = appConfig.result?.appName ?? ""
                    
                    if let colorString = appConfig.result?.appColor, let color = UIColor(hex: colorString) {
                        self?.weatherLbl.textColor = color
                    } else {
                        self?.weatherLbl.textColor = appThemeColor.CommonBlack
                    }
                }
            case .failure(let error):
                print("Failed to get AppConfig:", error)
            }
        }
    }


  
      }
