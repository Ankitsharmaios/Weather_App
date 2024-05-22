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
        
        
        countryView.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        numberView.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        
        
        btnNext.setTitleColor(appThemeColor.white, for: .normal)
        btnNext.titleLabel?.backgroundColor = appThemeColor.selectedCityColure
        
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
    
        numberValidation()
        let VerifyNumberVC = VerifyNumberVC.getInstance()
        VerifyNumberVC.modalPresentationStyle = .overCurrentContext
        
        present(VerifyNumberVC, animated: true)
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
extension UIViewController {
    static func currentViewcc() -> UIViewController? {
        var viewController = UIApplication.shared.windows.first?.rootViewController
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
}
