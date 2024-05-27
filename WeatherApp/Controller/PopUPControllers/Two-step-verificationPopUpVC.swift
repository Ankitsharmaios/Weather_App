//
//  Two-step-verificationPopUpVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 23/05/24.
//

import UIKit
import DPOTPView
import Toast_Swift
class Two_step_verificationPopUpVC: UIViewController,DPOTPViewDelegate {
   
 

    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var lblIncorrectPIN: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblYouwillbe: UILabel!
    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet weak var lblEnterYou: UILabel!
    
    var CheckTwoFactorData:CheckTwoFactorModel?
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
    override func viewWillAppear(_ animated: Bool) {
        lblIncorrectPIN.isHidden = true
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
        otpView.dpOTPViewDelegate = self
    }
   
    // DPOTPViewDelegate methods
    func dpOTPViewAddText(_ text: String, at position: Int) {
        self.lblIncorrectPIN.isHidden = true
        print("Added text \(text) at position \(position)")
        if position == 5 {
            print("====callAPI=====")
            CheckTwoFactor()
        }
    }

    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("Removed text \(text) at position \(position)")
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
}

extension Two_step_verificationPopUpVC{
    
    
    //MARK: Call Api
    func CheckTwoFactor(){
        let param = ["RegisterId":getString(key: userDefaultsKeys.RegisterId.rawValue),
                     "HashToken":getString(key: userDefaultsKeys.token.rawValue),
                     "Passcode":otpView.text ?? ""
                     ] as [String : Any]
        
        DataManager.shared.CheckTwoFactor(params: param,isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let CheckTwoFactor):
                print("CheckTwoFactor ", CheckTwoFactor)
                self?.CheckTwoFactorData = CheckTwoFactor
                
                if CheckTwoFactor.statusMessage?.lowercased() == "Passcode Matched".lowercased(){
                    DispatchQueue.main.async {
                        let controller =  TabBarVC.getInstance()
                               controller.modalPresentationStyle = .fullScreen
                        self?.present(controller, animated: true)
                    }
                }else{
                    self?.otpView.text = ""
                    self?.lblIncorrectPIN.isHidden = false
                    var toastStyle = ToastStyle()
                    toastStyle.backgroundColor = appThemeColor.text_Weather
                    self?.view.makeToast(CheckTwoFactor.statusMessage, duration: 2.0, position: .bottom, style: toastStyle)
                }
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
               
                self?.otpView.text = ""
                self?.lblIncorrectPIN.isHidden = false
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
