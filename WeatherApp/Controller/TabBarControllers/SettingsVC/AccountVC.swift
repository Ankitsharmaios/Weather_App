//
//  AccountVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import UIKit
import Toast_Swift

class AccountVC: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var btnBack: UIButton!
   
    var LogoutData:LogOutModel?
    var accountTitle = ["Security notifications","Passkeys","Email address","Two-step verification","Change number","Request account info","Logout"]
    var accountTitleImg = ["SecurityImg","PasskeysImg","EmailImg","twoStepverificationImg","changeNumberImg","RequestAccountInfoImg","LogoutImg"]
    class func getInstance()-> AccountVC {
        return AccountVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerNIb()
        // Do any additional setup after loading the view.
    }
   
    func setUpUI()
    {
        lblAccount.font = Helvetica.helvetica_bold.font(size: 16)
        lblAccount.textColor = appThemeColor.CommonBlack
    }
    
    func registerNIb()
    {
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
}
extension AccountVC:UITableViewDataSource & UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        cell.lblTitle.text = accountTitle[indexPath.row]
        let images = accountTitleImg[indexPath.row]
        cell.imageview.image = UIImage(named: images)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let selectedOption = accountTitle[indexPath.row]
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
    
}

extension AccountVC {
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

