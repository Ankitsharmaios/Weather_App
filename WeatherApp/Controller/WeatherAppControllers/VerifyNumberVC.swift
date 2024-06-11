//
//  VerifyNumberVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 22/05/24.
//

import UIKit
import DPOTPView
import EFCountingLabel
import Toast_Swift
class VerifyNumberVC: UIViewController {

  
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var lblcode: UILabel!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblYouMay: UILabel!
    @IBOutlet weak var lblNeedHelp: UILabel!
    @IBOutlet weak var lblEnter6digit: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var lblShowOtpCount: EFCountingLabel!
    @IBOutlet weak var lblOpenWhatsapp: UILabel!
    @IBOutlet weak var lblUseYour: UILabel!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var lblVerify: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var number = ""
    var counter = 60
    var userStatusMessage = ""
    var verifyOTPDATA:verifyOTPModel?
    var isTopTableHide = false
    
    class func getInstance()-> VerifyNumberVC {
        return VerifyNumberVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupOTPView()
        // Do any additional setup after loading the view.
    print("userStatusMessage",userStatusMessage)
        // Add tap gesture recognizer to the superview of mainView
       
    }
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.helpView.isHidden = true
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
            lblShowOtpCount.text = "0:\(counter)"
        }
    }
    
    func setUpUI()
    {
        lblVerify.font = Helvetica.helvetica_bold.font(size: 18)
        lblVerify.textColor = appThemeColor.selectedCityColure
        
//        lblUseYour.font = Helvetica.helvetica_semibold.font(size: 14)
//        lblUseYour.textColor = appThemeColor.CommonBlack
        
         helpView.isHidden = true
  //      lblOpenWhatsapp.font = Helvetica.helvetica_medium.font(size: 10)
        lblOpenWhatsapp.textColor = appThemeColor.text_LightColure
        lblcode.textColor = appThemeColor.text_LightColure
        
        
        
     //   lblEnter6digit.font = Helvetica.helvetica_medium.font(size: 15)
        lblEnter6digit.textColor = appThemeColor.text_LightColure
        
        lblNeedHelp.font = Helvetica.helvetica_bold.font(size: 15)
        lblNeedHelp.textColor = appThemeColor.Gray_Colure
        
      //  lblYouMay.font = Helvetica.helvetica_medium.font(size: 10)
        lblYouMay.textColor = appThemeColor.text_LightColure
        
        lblShowOtpCount.font = Helvetica.helvetica_bold.font(size: 15)
        lblShowOtpCount.textColor = appThemeColor.CommonBlack
        
        btnVerify.setTitleColor(appThemeColor.white, for: .normal)
        
        btnVerify.layer.cornerRadius = btnVerify.frame.size.height / 2
        btnVerify.clipsToBounds = true
        
        lblVerify.text = "Verify +91 \(number)"
    }
    

    func setHelpView()
    {
        helpView.layer.cornerRadius = 5
        helpView.addShadowToView(view: helpView, value: 3.0)
        
    }
    
    
    func setupOTPView()
    {
        otpView.count = 6
        otpView.spacing = 5
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = appThemeColor.text_LightColure
        otpView.selectedBorderColorTextField = appThemeColor.text_LightColure
        otpView.selectedBorderWidthTextField = 0.7
        otpView.borderWidthTextField = 0.7
        otpView.textColorTextField = appThemeColor.CommonBlack
        otpView.isBottomLineTextField = true
    }
    
    
    @IBAction func btnMoreoptionAction(_ sender: Any)
    {
        isTopTableHide.toggle()
        if isTopTableHide == true{
            self.helpView.isHidden = false
            self.setHelpView()
        }else{
            self.helpView.isHidden = true
        }
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
    }
    @IBAction func VerifyAction(_ sender: Any) 
    {
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = appThemeColor.text_Weather
       
        
        
        // Check if the number field is empty
        if otpView.text?.isEmpty == true {
            // If the text field is empty, show a toast message with custom style
            self.view.makeToast("OTP required", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }

        // Check if the mobile number is not 10 digits long
        if let OTP = otpView.text, OTP.count != 6 {
            // If the mobile number is not 10 digits long, show a toast message with custom style
            self.view.makeToast("Enter valid OTP", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
       
        
        
        self.view.endEditing(true)
        verifyOTP()
        
        
        
        
        
    }
}
extension VerifyNumberVC
{
      //MARK: Call Api
        func verifyOTP(){
            let param = ["DeviceName":AppSetting.DeviceType,
                         "DeviceVersion":AppSetting.DeviceVersion,
                         "UniqueId":AppSetting.DeviceId,
                         "PhoneNo": number,
                         "OTP": otpView.text ?? "",
                         "FCMToken":AppSetting.FCMTokenString
                         ] as [String : Any]
            
            DataManager.shared.VerifyOTP(params: param,isLoader: false, view: view) { [weak self] (result) in
                switch result {
                case .success(let verifyOTP):
                    print("verifyOTP ", verifyOTP)
                    self?.verifyOTPDATA = verifyOTP
                    
                        if verifyOTP.status == true {
                                        
                                        saveUserData(userData: verifyOTP)

                                        let userDetail = verifyOTP.result
                                      
                                        UserToken.userToken = userDetail?.hashToken ?? ""
                                        Singleton.sharedInstance.RegisterId = userDetail?.registerId ?? 0
                                        
                                        
                                        saveString(strin: UserToken.userToken, key: userDefaultsKeys.token.rawValue)
                                        saveString(strin: "\(Singleton.sharedInstance.RegisterId ?? 0)", key: userDefaultsKeys.RegisterId.rawValue)
                    
                            if self?.userStatusMessage.lowercased() == "User exist!".lowercased(){
                                DispatchQueue.main.async {
                                            let VerifyOTPVC =  Two_step_verificationPopUpVC.getInstance()
                                            VerifyOTPVC.modalPresentationStyle = .overCurrentContext
                                            self?.present(VerifyOTPVC, animated: true)
                                }
                            }else if  self?.userStatusMessage.lowercased() == "Data added successully".lowercased(){
                                DispatchQueue.main.async {
                                            let ProfileVC = ProfileVC.getInstance()
                                            ProfileVC.modalPresentationStyle = .overCurrentContext
                                            self?.present(ProfileVC, animated: true)
                                }
                            }
                                    } else {
                                        var toastStyle = ToastStyle()
                                        toastStyle.backgroundColor = appThemeColor.text_Weather
                                        self?.view.makeToast("Incorrect OTP", duration: 2.0, position: .bottom, style: toastStyle)
                                        
                                    }
                
                    
                
                    
                case .failure(let apiError):
                    print("Error ", apiError.localizedDescription)
                    
                }
            }
        }
    }
