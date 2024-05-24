//
//  WelcomeToTheWeatherAppVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 22/05/24.
//

import UIKit
import Toast_Swift
class WelcomeToTheWeatherAppVC: UIViewController , UITextFieldDelegate {

    
    @IBOutlet weak var lblWeatherAppWillNeed: UILabel!
    @IBOutlet weak var lblEnterYou: UILabel!
    @IBOutlet weak var lblWelcomeTo: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    var userRegisterData:RegisterModel?
    
    class func getInstance()-> WelcomeToTheWeatherAppVC {
        return WelcomeToTheWeatherAppVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        lblWelcomeTo.font = Helvetica.helvetica_bold.font(size: 23)
        lblEnterYou.font = Helvetica.helvetica_bold.font(size: 18)
        //  lblWeatherAppWillNeed.font = Helvetica.helvetica_medium.font(size: 14)
        
        
        countryView.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        numberView.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        
        
        btnNext.setTitleColor(appThemeColor.white, for: .normal)
        btnNext.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        
        btnNext.layer.cornerRadius = btnNext.frame.size.height / 2
        btnNext.clipsToBounds = true
        
        numberField.delegate = self
    }
    
    func numberValidation()
    {
        // Configure the toast style
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = appThemeColor.greenToast_Colure
       
        
        
        // Check if the number field is empty
        if numberField.text?.isEmpty == true {
            // If the text field is empty, show a toast message with custom style
            self.view.makeToast("Phone number required", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }

        // Check if the mobile number is not 10 digits long
        if let mobileNumber = numberField.text, mobileNumber.count != 10 {
            // If the mobile number is not 10 digits long, show a toast message with custom style
            self.view.makeToast("Enter valid Phone Number", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
    }

    @IBAction func nextAction(_ sender: Any)
    {
        
        // Configure the toast style
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = appThemeColor.text_Weather
       
        
        
        // Check if the number field is empty
        if numberField.text?.isEmpty == true {
            // If the text field is empty, show a toast message with custom style
            self.view.makeToast("Phone number required", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }

        // Check if the mobile number is not 10 digits long
        if let mobileNumber = numberField.text, mobileNumber.count != 10 {
            // If the mobile number is not 10 digits long, show a toast message with custom style
            self.view.makeToast("Enter valid Phone Number", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
        self.view.endEditing(true)
        self.userRegister()

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the text field is the mobile number text field
        if textField == numberField {
            // Get the new text after the replacement
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            // Check if the new text is a valid mobile number (only digits, up to 10 characters)
            let isValidMobileNumber = validateMobileNumber(text: newText)
            
            // Return whether the new text is valid
            return isValidMobileNumber
        }
        
        // For other text fields, return true to allow editing
        return true
    }
    
    // Function to validate mobile number
    func validateMobileNumber(text: String) -> Bool {
        // Regular expression for validating mobile numbers (only digits and exactly 10 characters)
        let mobileNumberRegex = "^\\d{0,10}$"
        
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        
        return mobileNumberPredicate.evaluate(with: text)
    }
    
    
    
    
    
}

extension WelcomeToTheWeatherAppVC
{
    //MARK: Call Api
    func userRegister(){
        let param = ["DeviceName":AppSetting.DeviceType,
                     "DeviceVersion":AppSetting.DeviceVersion,
                     "UniqueId":AppSetting.DeviceId,
                     "PhoneNo": numberField.text ?? "",
                     "FCMToken":AppSetting.FCMTokenString
                     ] as [String : Any]
        
        DataManager.shared.UserRegister(params: param,isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let userRegister):
                print("userRegister ", userRegister)
                self?.userRegisterData = userRegister
                
                if userRegister.statusMessage?.lowercased() == "User exist!".lowercased() || userRegister.statusMessage?.lowercased() == "Data added successully".lowercased(){
                    DispatchQueue.main.async {
                                let VerifyNumberVC = VerifyNumberVC.getInstance()
                                    VerifyNumberVC.modalPresentationStyle = .overCurrentContext
                                    VerifyNumberVC.number = self?.numberField.text ?? ""
                                    VerifyNumberVC.userStatusMessage = userRegister.statusMessage ?? ""
                        
                        self?.present(VerifyNumberVC, animated: true)
                    }
                }
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
}









extension UIViewController {
    static func currentViewcc() -> UIViewController? {
        var viewController = UIApplication.shared.windows.first?.rootViewController
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
}
