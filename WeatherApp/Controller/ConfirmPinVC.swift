//
//  ConfirmPinVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit
import DPOTPView
import Toast_Swift
class ConfirmPinVC: UIViewController & DPOTPViewDelegate{
    
    
    @IBOutlet weak var otpView: DPOTPView!
    
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitleTwoStep: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCreateA: UILabel!
    
    var isFrom = ""
    var pin = ""
    class func getInstance()-> ConfirmPinVC {
        return ConfirmPinVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupOTPView()
        // Do any additional setup after loading the view.
    }
    func setupUI()
    {
        lblTitleTwoStep.font = Helvetica.helvetica_semibold.font(size: 20)
        lblTitleTwoStep.textColor = appThemeColor.CommonBlack
        
        lblCreateA.textColor = appThemeColor.text_LightColure
        
        btnSave.setTitleColor(appThemeColor.text_LightColure, for: .normal)
      
        btnSave.layer.backgroundColor = appThemeColor.btnLightGrey_BackGround.cgColor
        
        
        btnSave.layer.cornerRadius = btnSave.frame.size.height / 2
        btnSave.clipsToBounds = true
        
        
    }
    
    func setupOTPView()
    {
        otpView.count = 6
        otpView.spacing = 5
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = appThemeColor.text_Weather
        otpView.selectedBorderColorTextField = appThemeColor.text_Weather
        otpView.selectedBorderWidthTextField = 0.7
        otpView.borderWidthTextField = 0.7
        otpView.textColorTextField = appThemeColor.CommonBlack
        otpView.isBottomLineTextField = true
        otpView.dpOTPViewDelegate = self
    }
    
    // DPOTPViewDelegate methods
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("Added text \(text) at position \(position)")
        if position == 5 {
            btnSave.layer.backgroundColor = appThemeColor.text_Weather.cgColor
            btnSave.setTitleColor(appThemeColor.white, for: .normal)
        }
    }

    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("Removed text \(text) at position \(position)")
        btnSave.layer.backgroundColor = appThemeColor.btnLightGrey_BackGround.cgColor
        btnSave.setTitleColor(appThemeColor.text_LightColure, for: .normal)
    }

    func dpOTPViewBecomeFirstResponder() {
        print("Become first responder")
    }

    func dpOTPViewResignFirstResponder() {
        print("Resign first responder")
    }

    func getCurrentOTP() -> String {
        // Concatenate the text from all the text fields in otpView
        return otpView.text ?? ""
    }
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("")
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: false)
    }
    
    @IBAction func saveAction(_ sender: Any)
    {
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = appThemeColor.text_Weather
        
        // Check if the number field is empty
        if otpView.text?.isEmpty == true {
            // If the text field is empty, show a toast message with custom style
            self.view.makeToast("PIN required", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
        // Check if the mobile number is not 10 digits long
        if let OTP = otpView.text, OTP.count != 6 {
            // If the mobile number is not 10 digits long, show a toast message with custom style
            self.view.makeToast("Enter valid PIN", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
        if otpView.text != pin{
            self.view.makeToast("Incorrect PIN", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
        self.view.endEditing(true)
        if isFrom == "Account"
        {
            AddTwoStepVerificationcode(type: "Edit")
        }else {
            AddTwoStepVerificationcode(type: "Add")
            }
}
}
extension ConfirmPinVC
{
    //MARK: Call Api
    func AddTwoStepVerificationcode(type:String){
        let param = ["RegisterId":getString(key: userDefaultsKeys.RegisterId.rawValue),
                     "Hashtoken":getString(key: userDefaultsKeys.token.rawValue),
                     "Passcode":otpView.text ?? "",
                     "PasscodeEnable":"true",
                     "Type":type
                     ] as [String : Any]
        
        DataManager.shared.AddTwoStepVerificationcode(params: param,isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let AddTwoStepVerificationcode):
                print("AddTwoStepVerificationcode ", AddTwoStepVerificationcode)
                
                
                if AddTwoStepVerificationcode.statusMessage?.lowercased() == "Added successully".lowercased() {
                    DispatchQueue.main.async {
                                    let TabBarVC = TabBarVC.getInstance()
                                    TabBarVC.modalPresentationStyle = .overCurrentContext
                                    self?.present(TabBarVC, animated: true)
                    }
                }else if AddTwoStepVerificationcode.statusMessage?.lowercased() == "Edit successully".lowercased() {
                    DispatchQueue.main.async {
                        let controller =  Two_step_verificationVC.getInstance()
                        controller.modalPresentationStyle = .fullScreen
                        controller.isFromScreen = "Account"
                        self?.present(controller, animated: true)
                    }
                }
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
    
   
    
    }
