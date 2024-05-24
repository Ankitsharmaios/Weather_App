//
//  InnerChatVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import UIKit
import IQKeyboardManagerSwift

class InnerChatVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var pimBtn: UIButton!
    @IBOutlet weak var bottomstackView: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var openEmojiBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var vcallBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bgView: UIView!
    let placeholderText = "Message"
    class func getInstance()-> InnerChatVC {
        return InnerChatVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
 
    func setupUI(){
        userImageView.layer.cornerRadius = userImageView.layer.bounds.height / 2
        nameLbl.font = Helvetica.helvetica_bold.font(size: 15)
        statusLbl.font = Helvetica.helvetica_regular.font(size: 11)
        statusLbl.textColor = appThemeColor.text_LightColure
        bottomView.layer.cornerRadius = 20
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = .lightGray
  
    }
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.textColor == .lightGray {
               textView.text = nil
               textView.textColor = .black
           }
       }

       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = placeholderText
               textView.textColor = .lightGray
           }
       }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
