//
//  EditProfileVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 18/06/24.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var userImgaeView: UIImageView!
    @IBOutlet weak var CameraImgView: UIImageView!
    
    
    class func getInstance()-> EditProfileVC {
        return EditProfileVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        lblProfile.font = Nunitonsans.nuniton_regular.font(size: 15)
        lblProfile.textColor = appThemeColor.CommonBlack
        
        userImgaeView.layer.cornerRadius = userImgaeView.frame.size.width / 2
        userImgaeView.clipsToBounds = true
        
        
        CameraImgView.layer.cornerRadius = CameraImgView.frame.size.width / 2
        CameraImgView.clipsToBounds = true
        
    }
    
}
