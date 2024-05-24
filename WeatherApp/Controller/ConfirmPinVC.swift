//
//  ConfirmPinVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit
import DPOTPView
import Toast_Swift
class ConfirmPinVC: UIViewController {

    
    @IBOutlet weak var otpView: DPOTPView!
    

    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitleTwoStep: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCreateA: UILabel!
   
    
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
        
        btnSave.setTitleColor(appThemeColor.white, for: .normal)
        btnSave.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        
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
        AddTwoStepVerificationcode()
    }
    
}
extension ConfirmPinVC
{
    //MARK: Call Api
    func AddTwoStepVerificationcode(){
        let param = ["RegisterId":"\(Singleton.sharedInstance.RegisterId ?? 0)",
                     "Hashtoken":getString(key: userDefaultsKeys.token.rawValue),
                     "Passcode":otpView.text ?? "",
                     "PasscodeEnable":"true",
                     "Type":"Add"
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
                }else{
                    
                }
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
    
   
    
    }
