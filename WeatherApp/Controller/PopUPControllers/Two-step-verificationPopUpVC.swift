//
//  Two-step-verificationPopUpVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 23/05/24.
//

import UIKit
import DPOTPView
class Two_step_verificationPopUpVC: UIViewController {

    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblYouwillbe: UILabel!
    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet weak var lblEnterYou: UILabel!
    
    
    class func getInstance()-> Two_step_verificationPopUpVC {
        return Two_step_verificationPopUpVC.viewController(storyboard: Constants.Storyboard.PopUp)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupOTPView()
        setAttributedText()
        settopcorner()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        lblEnterYou.textColor = appThemeColor.white
        lblYouwillbe.textColor = appThemeColor.text_LightColure
        
        topGreenView.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        
        mainView.layer.cornerRadius = 5
    }

    func settopcorner()
    {
        let CornerRadius: CGFloat = 5 // Adjust the corner radius as needed
        topGreenView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topGreenView.layer.cornerRadius = CornerRadius
        topGreenView.clipsToBounds = true
    }
    
    
    
    func setAttributedText() {
        // Full text
        let fullText = "You will be asked for it periodically to help you remember it. Forgot PIN?"

        // Create an NSMutableAttributedString
        let attributedString = NSMutableAttributedString(string: fullText)

        // Define the attributes for the "Forgot PIN?" part
        let greenAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: appThemeColor.text_Weather
        ]

        // Find the range of "Forgot PIN?" in the full text
        if let range = fullText.range(of: "Forgot PIN?") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttributes(greenAttributes, range: nsRange)
        }

        // Assign the attributed string to the label
        lblYouwillbe.attributedText = attributedString
    }
    
    
    func setupOTPView()
    {
        otpView.count = 6
        otpView.spacing = 5
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = appThemeColor.greenToast_Colure
        otpView.selectedBorderColorTextField = appThemeColor.greenToast_Colure
        otpView.selectedBorderWidthTextField = 0.7
        otpView.borderWidthTextField = 0.7
        otpView.textColorTextField = appThemeColor.CommonBlack
        otpView.isBottomLineTextField = true
    }
    
    
}
