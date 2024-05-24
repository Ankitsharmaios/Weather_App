//
//  PinSetVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit
import DPOTPView
import Toast_Swift

class PinSetVC: UIViewController {

    
    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitleTwoStep: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCreateA: UILabel!
    
    
    
    class func getInstance()-> PinSetVC {
        return PinSetVC.viewController(storyboard: Constants.Storyboard.Main)
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
        
        btnNext.setTitleColor(appThemeColor.text_LightColure, for: .normal)
      
        btnNext.layer.backgroundColor = appThemeColor.btnLightGrey_BackGround.cgColor
        
        
        btnNext.layer.cornerRadius = btnNext.frame.size.height / 2
        btnNext.clipsToBounds = true
        
        
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
    @IBAction func nextAction(_ sender: Any) 
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
        
        self.view.endEditing(true)
        
        DispatchQueue.main.async {
                    let ConfirmPinVC = ConfirmPinVC.getInstance()
                    ConfirmPinVC.modalPresentationStyle = .overCurrentContext
                    ConfirmPinVC.pin = self.otpView.text ?? ""
                    self.present(ConfirmPinVC, animated: false)
        }
    }
}
