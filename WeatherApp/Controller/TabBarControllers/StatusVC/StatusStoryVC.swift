//
//  StatusStoryVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/05/24.
//

import UIKit
import SDWebImage
class StatusStoryVC: UIViewController {

    

    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var btnMoreoption: UIButton!
    @IBOutlet weak var lblStatusTime: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var showTabBar: (() -> Void )?
    var userImg = ""
    var userName = ""
    class func getInstance()-> StatusStoryVC {
        return StatusStoryVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUserData()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        
        lblUsername.font = Helvetica.helvetica_regular.font(size: 16)
        lblUsername.textColor = appThemeColor.CommonBlack
        
        lblStatusTime.font = Helvetica.helvetica_regular.font(size: 12)
        lblStatusTime.textColor = appThemeColor.CommonBlack
        
        
        
        replyTextView.layer.cornerRadius = replyTextView.frame.size.height / 2
        replyTextView.layer.masksToBounds = true
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = appThemeColor.white.cgColor
    }
    
    func setUserData() {
            
            let imageURLString = userImg
            
        
            lblUsername.text = userName
            
            if let imageURL = URL(string: imageURLString) {
                userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
            } else {
                userImageView.image = UIImage(named: "placeholder")
            }
        }
    

    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true){
            self.showTabBar?()
        }
    }
    
    @IBAction func moreOptionAction(_ sender: Any) {
    }
}
