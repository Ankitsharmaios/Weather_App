//
//  VerifyNumberVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 22/05/24.
//

import UIKit
import DPOTPView
import EFCountingLabel
class VerifyNumberVC: UIViewController {

  
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
    
    var counter = 60
    class func getInstance()-> VerifyNumberVC {
        return VerifyNumberVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupOTPView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
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
        
        
  //      lblOpenWhatsapp.font = Helvetica.helvetica_medium.font(size: 10)
        lblOpenWhatsapp.textColor = appThemeColor.text_LightColure
        lblcode.textColor = appThemeColor.text_LightColure
        
        
        
     //   lblEnter6digit.font = Helvetica.helvetica_medium.font(size: 15)
        lblEnter6digit.textColor = appThemeColor.text_LightColure
        
        lblNeedHelp.font = Helvetica.helvetica_bold.font(size: 15)
        lblNeedHelp.textColor = appThemeColor.CommonBlack
        
      //  lblYouMay.font = Helvetica.helvetica_medium.font(size: 10)
        lblYouMay.textColor = appThemeColor.text_LightColure
        
        lblShowOtpCount.font = Helvetica.helvetica_bold.font(size: 15)
        lblShowOtpCount.textColor = appThemeColor.CommonBlack
        
        btnVerify.setTitleColor(appThemeColor.white, for: .normal)
        
        btnVerify.layer.cornerRadius = btnVerify.frame.size.height / 2
        btnVerify.clipsToBounds = true
        
    }
    

    
    
    
    func setupOTPView()
    {
        otpView.count = 6
        otpView.spacing = 5
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = appThemeColor.text_LightColure
        otpView.selectedBorderColorTextField = appThemeColor.text_LightColure
        otpView.borderWidthTextField = 0.7
        otpView.textColorTextField = appThemeColor.CommonBlack
        otpView.isBottomLineTextField = true
        
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
