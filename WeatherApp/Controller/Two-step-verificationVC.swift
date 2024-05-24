//
//  Two-step-verificationVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit

class Two_step_verificationVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitleTowStep: UILabel!
    @IBOutlet weak var lblForExtra: UILabel!
    @IBOutlet weak var btnTurnOn: UIButton!
    
    
    
    class func getInstance()-> Two_step_verificationVC {
        return Two_step_verificationVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func SetUpUI()
    {
        lblTitleTowStep.font = Helvetica.helvetica_semibold.font(size: 20)
        lblTitleTowStep.textColor = appThemeColor.CommonBlack
        
        lblForExtra.textColor = appThemeColor.text_LightColure
        
        btnTurnOn.setTitleColor(appThemeColor.white, for: .normal)
        btnTurnOn.layer.backgroundColor = appThemeColor.text_Weather.cgColor
        
        btnTurnOn.layer.cornerRadius = btnTurnOn.frame.size.height / 2
        btnTurnOn.clipsToBounds = true
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
    

}
