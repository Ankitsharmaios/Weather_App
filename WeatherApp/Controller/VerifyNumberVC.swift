//
//  VerifyNumberVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 22/05/24.
//

import UIKit
import DPOTPView
class VerifyNumberVC: UIViewController {

  
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblShowOtpCount: UILabel!
    @IBOutlet weak var lblYouMay: UILabel!
    @IBOutlet weak var lblNeedHelp: UILabel!
    @IBOutlet weak var lblEnter6digit: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var lblOpenWhatsapp: UILabel!
    @IBOutlet weak var lblUseYour: UILabel!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var lblVerify: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    class func getInstance()-> VerifyNumberVC {
        return VerifyNumberVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupOTPView()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        lblVerify.font = Helvetica.helvetica_bold.font(size: 18)
        lblVerify.textColor = appThemeColor.selectedCityColure
        
        lblUseYour.font = Helvetica.helvetica_semibold.font(size: 10)
        lblUseYour.textColor = appThemeColor.CommonBlack
        
        
        lblOpenWhatsapp.font = Helvetica.helvetica_medium.font(size: 10)
        lblOpenWhatsapp.textColor = appThemeColor.text_LightColure
        
        
        
        lblEnter6digit.font = Helvetica.helvetica_medium.font(size: 10)
        lblEnter6digit.textColor = appThemeColor.text_LightColure
        
        lblNeedHelp.font = Helvetica.helvetica_semibold.font(size: 10)
        lblNeedHelp.textColor = appThemeColor.CommonBlack
        
        lblYouMay.font = Helvetica.helvetica_medium.font(size: 10)
        lblYouMay.textColor = appThemeColor.text_LightColure
        
        lblShowOtpCount.font = Helvetica.helvetica_bold.font(size: 10)
        lblShowOtpCount.textColor = appThemeColor.CommonBlack
    }
    
    func setupOTPView()
    {
      //  imageView.contentMode = .scaleAspectFit
        otpView.count = 6
        otpView.spacing = 2
        // otpView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(17.0))!
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = appThemeColor.text_LightColure
        //otpView.selectedBorderColorTextField = appThemeColor.Dark_Grey
      //  otpView.borderWidthTextField = 0.7
     //   otpView.selectedBorderWidthTextField = 1.0
        otpView.backGroundColorTextField = appThemeColor.white
        otpView.backGroundColorFilledTextField = appThemeColor.white
        otpView.textColorTextField = appThemeColor.CommonBlack
        otpView.isBottomLineTextField = true
        otpView.isCursorHidden = false
        // otpView.text = OtpPinsave
        // otpView.validate()
      //  otpView.isSecureTextEntry = true
        otpView.becomeFirstResponder()
    }
    
    
    @IBAction func btnMoreoptionAction(_ sender: Any)
    {
        
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
    }
    @IBAction func VerifyAction(_ sender: Any) 
    {
        
    }
}
