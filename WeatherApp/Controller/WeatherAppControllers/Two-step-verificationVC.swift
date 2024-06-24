//
//  Two-step-verificationVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit

class Two_step_verificationVC: UIViewController {

    @IBOutlet weak var lblForextraLeadingLayout: NSLayoutConstraint!
    @IBOutlet weak var lblForextraTralingLayout: NSLayoutConstraint!
    @IBOutlet weak var btnChangePin: UIButton!
    @IBOutlet weak var lblChangePin: UILabel!
    @IBOutlet weak var changePinImg: UIImageView!
    @IBOutlet weak var changePinView: UIView!
    @IBOutlet weak var btnTurnOf: UIButton!
    @IBOutlet weak var turnOfImg: UIImageView!
    @IBOutlet weak var lblTurnOf: UILabel!
    @IBOutlet weak var turnOfView: UIView!
    @IBOutlet weak var hidesepretorLine: UIView!
    @IBOutlet weak var starImageview: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitleTowStep: UILabel!
    @IBOutlet weak var lblForExtra: UILabel!
    @IBOutlet weak var btnTurnOn: UIButton!
    @IBOutlet weak var trunOfViewHeightLayout: NSLayoutConstraint!
    
    var isFromScreen = ""
    class func getInstance()-> Two_step_verificationVC {
        return Two_step_verificationVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("dismiss"), object: nil)
        SetUpUI()
        changeUI()
        turnOfView.isHidden = true
        trunOfViewHeightLayout.constant = 0
        // Do any additional setup after loading the view.
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.dismiss(animated: true){
          //  self.showTabbar?()
        }
    }
    func changeUI()
    {
        if isFromScreen == "Account"
        {
            lblTitleTowStep.font = Helvetica.helvetica_medium.font(size: 18)
            lblTitleTowStep.textColor = appThemeColor.CommonBlack
            
            lblTurnOf.font = Helvetica.helvetica_regular.font(size: 16)
            lblTurnOf.textColor = appThemeColor.text_LightColure
            
            lblChangePin.font = Helvetica.helvetica_regular.font(size: 16)
            lblChangePin.textColor = appThemeColor.text_LightColure
            
            lblForExtra.text = "Two-step verification is on. You'll need to enter your PIN if you register your phone number on W-Messenger again."
            
            lblForExtra.textColor = appThemeColor.text_LightColure
            
            btnTurnOn.isHidden = true
            
            starImageview.image = UIImage(named: "CheckStarImg")
            
            hidesepretorLine.isHidden = false
            turnOfView.isHidden = false
            changePinView.isHidden = false
            
            lblForextraLeadingLayout.constant = 7
            lblForextraTralingLayout.constant = 7
        }
        
    }
    func SetUpUI()
    {
        lblTitleTowStep.font = Helvetica.helvetica_medium.font(size: 20)
        lblTitleTowStep.textColor = appThemeColor.CommonBlack
        
        lblForExtra.textColor = appThemeColor.text_LightColure
        
        btnTurnOn.setTitleColor(appThemeColor.white, for: .normal)
        btnTurnOn.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        
        btnTurnOn.layer.cornerRadius = btnTurnOn.frame.size.height / 2
        btnTurnOn.clipsToBounds = true
        
        
        lblForextraLeadingLayout.constant = 15
        lblForextraTralingLayout.constant = 15
        hidesepretorLine.isHidden = true
        turnOfView.isHidden = true
        changePinView.isHidden = true
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func turnOnAction(_ sender: Any)
    {
        DispatchQueue.main.async {
                    let PinSetVC = PinSetVC.getInstance()
                    PinSetVC.modalPresentationStyle = .overCurrentContext
                    self.present(PinSetVC, animated: true)
        }
    }
    
    @IBAction func turnOffAction(_ sender: Any)
    {
        
    }
    @IBAction func changePinAction(_ sender: Any) 
    {
        DispatchQueue.main.async {
                    let PinSetVC = PinSetVC.getInstance()
                    PinSetVC.modalPresentationStyle = .overCurrentContext
                    PinSetVC.isFrom = "Account"
                    self.present(PinSetVC, animated: true)
        }
    }
    
}
