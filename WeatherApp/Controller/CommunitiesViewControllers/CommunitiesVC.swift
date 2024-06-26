//
//  CommunitiesVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 17/06/24.
//

import UIKit
import FirebaseDatabase
import FirebaseMessaging
import Firebase
import SDWebImage

class CommunitiesVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate & UITableViewDataSource & UITableViewDelegate {

    @IBOutlet weak var btnCreateGroup: UIButton!
    @IBOutlet weak var createGroupView: UIView!
    @IBOutlet weak var communitiesTableView: UITableView!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var btnMoreOptions: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCommunitiesTitle: UILabel!
   
    var isTopTableHide = false
    var OptionNames:[String] = ["Settings"]
    var communitiesData:[CommunitiesListModel]?
    var ref: DatabaseReference!
    class func getInstance()-> CommunitiesVC {
        return CommunitiesVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setNib()
        fetchFirebaseData()
        navigationController?.navigationBar.isHidden = true
        topTableView.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.topTableView.isHidden = true
    }
    
    func setNib()
    {
        topTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil),forCellReuseIdentifier: "optionHeaderTblvCell")
        topTableView.dataSource = self
        topTableView.delegate = self
        topTableView.separatorStyle = .none
        topTableView.layer.cornerRadius = 8
        topTableView.layer.masksToBounds = false
        topTableView.addShadowToTableView(view: topTableView, value: 2)
        communitiesTableView.register(UINib(nibName: "ChatsTBlvCell", bundle: nil),forCellReuseIdentifier: "ChatsTBlvCell")
        communitiesTableView.dataSource = self
        communitiesTableView.delegate = self
        communitiesTableView.separatorStyle = .none
    }
    
    func setUpUI()
    {
        lblCommunitiesTitle.font = Nunitonsans.nuniton_regular.font(size: 22)
        lblCommunitiesTitle.textColor = appThemeColor.CommonBlack
        
        btnCreateGroup.titleLabel?.font = Helvetica.helvetica_medium.font(size: 5)
        
        btnCreateGroup.setTitleColor(appThemeColor.white, for: .normal)
        btnCreateGroup.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        
        btnCreateGroup.layer.cornerRadius = btnCreateGroup.frame.size.height / 2
        btnCreateGroup.clipsToBounds = true
        
        
    }
    
    @IBAction func createNewGroupAction(_ sender: Any) 
    {
        DispatchQueue.main.async {
            let ContactVc = ContactsViewController.getInstance()
            ContactVc.isfrom = "Communities"
            ContactVc.modalPresentationStyle = .overCurrentContext
            ContactVc.stackViewHideShow.isHidden = true
            ContactVc.stackviewHeightlayout.constant = 0
            ContactVc.view.layoutIfNeeded()
            ContactVc.updateHeaderViewHeight(newHeight: 40)
            
            ContactVc.showTabbar = {
                self.showTabBar(animated: true)
            }
            self.topTableView.isHidden = true
            self.hideTabBar(animated: true)
            self.present(ContactVc, animated: true)
        }
    }
    
    @IBAction func cameraAction(_ sender: Any) 
    {
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
    @IBAction func moreOptionAction(_ sender: Any)
    {
        isTopTableHide.toggle()
        if isTopTableHide == true{
            self.topTableView.isHidden = false
        }else{
            self.topTableView.isHidden = true
        }
    }
    
}
// MARK: TableView Methods
extension CommunitiesVC
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == communitiesTableView{
            return 1
        }else if tableView == topTableView{
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == communitiesTableView{
            if communitiesData?.count ?? 0 > 0 {
                return communitiesData?.count ?? 0
            }else{
                return 0
            }
        }else if tableView == topTableView{
            return OptionNames.count
        }
      return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == communitiesTableView{
            if let cell = communitiesTableView .dequeueReusableCell(withIdentifier: "ChatsTBlvCell", for: indexPath) as? ChatsTBlvCell{
                cell.usernameLbl.text = communitiesData?[indexPath.row].groupName ?? ""
                cell.messageLbl.text = communitiesData?[indexPath.row].lastmessage ?? ""
                if let lastMessageDate = communitiesData?[indexPath.row].lastmessagedate,
                           let convertedDate = Converter.convertDateFormat(dateString: lastMessageDate) {
                            cell.timeLbl?.text = convertedDate
                            cell.timeLbl?.isHidden = false
                        } else {
                            cell.timeLbl?.isHidden = true
                        }
               
                cell.msgLeadingLayout.constant = -13
                cell.ViewStatusImage.isHidden = true
                cell.userImageView.layer.cornerRadius = 10
                
                
                if let imageUrl2 = URL(string: communitiesData?[indexPath.row].groupIcon ?? "") {
                    cell.userImageView?.sd_setImage(with: imageUrl2, placeholderImage: UIImage(named: "Place_Holder"))

                }else {
                    cell.userImageView.image = UIImage(named: "Place_Holder")
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
        if tableView == communitiesTableView{
            return 70
        }else if tableView == topTableView{
            return 43
        }
        return CGFloat()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if tableView == communitiesTableView {
            let controller = InnerChatVC.getInstance()
            controller.modalPresentationStyle = .overFullScreen
            controller.UserName = communitiesData?[indexPath.row].groupName ?? ""
            if let selectedChat = communitiesData?[indexPath.row] {
                     
                controller.communitiesData = selectedChat
        
            }

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
extension CommunitiesVC {
    // MARK: Firebase Data Method LastChat
    func fetchFirebaseData() {
        ref = Database.database().reference()
        ref.getData { [self] error, snap in
            if let error = error {
                print("Error in fetching from firebase: \(error)")
                fetchFirebaseData()
            } else if let snap = snap, snap.exists() {
                ref.child("\(firebaseTableName.GroupChat)").observe(.value, with: { [self] (snapshot) in
                    var tempCommunitiesData: [CommunitiesListModel] = []

                    for child in snapshot.children {
                        let childSnap = child as! DataSnapshot
                        if let userDict = childSnap.value as? [String: Any] {
                            if let chatData = CommunitiesListModel(JSON: userDict) {

                                if let adminId = userDict["adminId"] as? String,
                                   let registerID = getString(key: userDefaultsKeys.RegisterId.rawValue) as String?,
                                   let membersArray = userDict["members"] as? [[String: Any]] {

                                    var isAdmin = false
                                    var isMemberMatch = false

                                    for memberDict in membersArray {
                                        if let memberId = memberDict["id"] as? Int, String(memberId) == registerID {
                                            isMemberMatch = true
                                            break
                                        }
                                    }

                                    if adminId == registerID {
                                        isAdmin = true
                                    }

                                    if isAdmin || isMemberMatch {
                                        tempCommunitiesData.append(chatData)
                                    }
                                }
                            }
                        }
                    }
                    self.communitiesData = tempCommunitiesData

                    // Show or hide table view and empty view based on data
                    if let communitiesData = self.communitiesData, !communitiesData.isEmpty {
                        self.communitiesTableView.isHidden = false
                        self.createGroupView.isHidden = true
                        self.communitiesTableView.reloadData()
                        print("self.communitiesData====>", self.communitiesData)
                    } else {
                        self.communitiesTableView.isHidden = true
                        self.createGroupView.isHidden = false
                    }
                })
            } else {
                print("No data available")
                self.communitiesTableView.isHidden = true
                self.createGroupView.isHidden = false
            }
        }

    }
}
