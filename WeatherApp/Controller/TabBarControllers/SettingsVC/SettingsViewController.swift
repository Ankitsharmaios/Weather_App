//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import UIKit
import SDWebImage
class SettingsViewController: UIViewController {

    @IBOutlet weak var lblUserStatus: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var showTabbar: (() -> Void )?
    var settingTitles = ["Account","Privacy","Avtar","Chats","Notification","Storage and data","App Language","Help"]
    var settingSubtitle = ["Security notifications,change number","Block contacts,disappearing messages","Create ‚edit, profile photo","Theme,wallpapers,chat history","Message,group & call tones","Network usage,auto-download","English(device's language)","Help center,contact us, privicy policy"]
    var settingImages = ["AccountImg","PrivacyImg","AvatarImg","ChatsImg","NotificationImg","StorageandDataImg","AppLanguageImg","HelpImg"]
    
    class func getInstance()-> SettingsViewController {
        return SettingsViewController.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        registerNib()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        edituserData()
        setUserData()
    }
    func setUserData() {
            let userdata = getUserData()
            let name = userdata?.result?.name ?? ""
            let imageURLString = userdata?.result?.image ?? ""
            
            lblUserName.text = name
            
            if let imageURL = URL(string: imageURLString) {
                userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
            } else {
                userImage.image = UIImage(named: "placeholder")
            }
        }
    func edituserData()
    {
        if Singleton.sharedInstance.EditProfileData?.result?.name?.count ?? 0 > 0
        {
            let userdata = Singleton.sharedInstance.EditProfileData?.result
            let name = userdata?.name ?? ""
            let imageURLString = userdata?.userImage ?? ""
            
            lblUserName.text = name
            
            if let imageURL = URL(string: imageURLString) {
                userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
            } else {
                userImage.image = UIImage(named: "placeholder")
            }
        }
    }
    
    func setUpUi()
    {
    
        lblSettings.font = Helvetica.helvetica_regular.font(size: 20)
        lblSettings.textColor = appThemeColor.CommonBlack
        
        lblUserName.font = Helvetica.helvetica_regular.font(size: 18)
        lblUserName.textColor = appThemeColor.CommonBlack
        
        lblUserStatus.font = Helvetica.helvetica_regular.font(size: 15)
        lblUserStatus.textColor = appThemeColor.text_LightColure
        
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
    }
    
    func registerNib()
    {

        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true) {
            self.showTabbar?()
        }
    }
    
}
extension SettingsViewController:UITableViewDataSource & UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        cell.lblTitle.text = settingTitles[indexPath.row]
        cell.lblsubTitle.text = settingSubtitle[indexPath.row]
        let imageName = settingImages[indexPath.row]
        cell.userImageView.image = UIImage(named: imageName)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let selectedOption = settingTitles[indexPath.row]
            if selectedOption == "Account" {
                
                DispatchQueue.main.async {
                    
                    let AccountVC = AccountVC.getInstance()
                    AccountVC.modalPresentationStyle = .overCurrentContext
                    self.present(AccountVC, animated: true)
                }
            }
}
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
