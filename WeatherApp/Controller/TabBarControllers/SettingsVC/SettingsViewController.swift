//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import UIKit
import Toast_Swift
import SDWebImage

class SettingsViewController: UIViewController {

    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var lblUserStatus: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var LogoutData:LogOutModel?
    var showTabbar: (() -> Void )?
    var settingTitles = ["Two-step verification","Notifications","Storage and data","Logout"]
    var settingSubtitle = ["","Message,group & call tones","Network usage,auto-download",""]
    var settingImages = ["twoStepverificationImg","NotificationImg","StorageandDataImg","LogoutImg"]
    
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
        
    }
    func setUserData() {
            let userdata = getUserData()
            let name = userdata?.result?.name ?? ""
            let imageURLString = userdata?.result?.image ?? ""
            let about = userdata?.result?.about ?? ""
        
        
            lblUserStatus.text = about
            lblUserName.text = name
            
            if let imageURL = URL(string: imageURLString) {
                userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
            } else {
                userImage.image = UIImage(named: "Place_Holder")
            }
        }
    func edituserData()
    {
        if Singleton.sharedInstance.EditProfileData?.result?.name?.count ?? 0 > 0
        {
          
            let userdata = Singleton.sharedInstance.EditProfileData?.result
            let name = userdata?.name ?? ""
            let imageURLString = userdata?.userImage ?? ""
            let about = userdata?.about ?? ""
            
            lblUserStatus.text = about
            lblUserName.text = name
            
            if let imageURL = URL(string: imageURLString) {
                userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
            } else {
                userImage.image = UIImage(named: "Place_Holder")
            }
        }else{
            setUserData()
        }
    }
    
    func setUpUi()
    {
    
        lblSettings.font = Helvetica.helvetica_regular.font(size: 20)
        lblSettings.textColor = appThemeColor.CommonBlack
        
        lblUserName.font = Helvetica.helvetica_regular.font(size: 19)
        lblUserName.textColor = appThemeColor.CommonBlack
        
        lblUserStatus.font = Helvetica.helvetica_regular.font(size: 12)
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
    
    @IBAction func editProfileAction(_ sender: Any)
    {
        let EditProfileVC = EditProfileVC.getInstance()
        EditProfileVC.modalPresentationStyle = .overCurrentContext
        EditProfileVC.callback = { [weak self] about,name in
           if about == ""
            {
             //  self?.edituserData()
           }else{
               self?.lblUserStatus.text = about
               self?.lblUserName.text = name
           }
            
            
                        }
        
        self.present(EditProfileVC, animated: true)
        
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
        
        // Set the title label
        cell.lblTitle.text = settingTitles[indexPath.row]
        
        // Check if indexPath is 0 or 3 to hide subtitle label
        if indexPath.row == 0 || indexPath.row == 3 {
            cell.titleTopLayout.constant = 20
            cell.lblsubTitle.isHidden = true
        } else {
            cell.lblsubTitle.isHidden = false
            cell.lblsubTitle.text = settingSubtitle[indexPath.row]
        }
        
        // Set the image
        let imageName = settingImages[indexPath.row]
        cell.userImageView.image = UIImage(named: imageName)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedOption = settingTitles[indexPath.row]
        if selectedOption == "Logout" {
            DispatchQueue.main.async {
                self.Logout()
            }
        }else if selectedOption == "Two-step verification"{
            DispatchQueue.main.async {
                let controller =  Two_step_verificationVC.getInstance()
                controller.modalPresentationStyle = .fullScreen
                controller.isFromScreen = "Account"
                self.present(controller, animated: true)
            }
        }
 
}
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SettingsViewController {
    // MARK: Call Api
    func Logout() {
        let param = ["RegisterId": getString(key: userDefaultsKeys.RegisterId.rawValue),
                     "HashToken": getString(key: userDefaultsKeys.token.rawValue)]
        
        DataManager.shared.Logout(params: param, isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let Logout):
                print("Logout ", Logout)
                self?.LogoutData = Logout
                
                if Logout.statusMessage?.lowercased() == "logged out successfully" {
                    removeUserDefaultsKey(key: userDefaultsKeys.userdata.rawValue)
                    removeUserDefaultsKey(key: userDefaultsKeys.RegisterId.rawValue)
                    DispatchQueue.main.async {
                        var toastStyle = ToastStyle()
                        toastStyle.backgroundColor = appThemeColor.CommonBlack
                        toastStyle.messageFont = UIFont.systemFont(ofSize: 13.0) // Adjust the font size to make the text smaller
                        
                        self?.view.makeToast(Logout.statusMessage, duration: 1.0, position: .bottom, style: toastStyle)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self?.restartApp()
                        }
                    }
                }
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
            }
        }
    }
    
    func restartApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
