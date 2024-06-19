//
//  NamePopUpVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 19/06/24.
//

import UIKit
import Toast_Swift
import MCEmojiPicker

class NamePopUpVC: UIViewController {
   
    

    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnEmogi: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lblEnteryourname: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnback: UIButton!
   
    var username = ""
    var callback: ((String) -> Void)?
    var isfrom = ""
    var selectedData: String?
    class func getInstance()-> NamePopUpVC {
        return NamePopUpVC.viewController(storyboard: Constants.Storyboard.PopUp)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        nameTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func setupUI()
    {
        lblEnteryourname.font = Helvetica.helvetica_medium.font(size: 15)
        lblEnteryourname.textColor = appThemeColor.CommonBlack
        
        if isfrom == "About"
        {
            nameTextField.text = selectedData
            lblEnteryourname.text = "Add About"
        }else{
            nameTextField.text = username
        }
        
        

        
    }
    
    
    @IBAction func cancelAction(_ sender: Any)
    {
        self.dismiss(animated: true)
        {
            self.nameTextField.resignFirstResponder()
        }
    }
    @IBAction func emojiAction(_ sender: Any)
    {
        
    }
   
    
    
    @IBAction func actionSave(_ sender: Any) 
    {
       
        if isfrom == "About"
        {

            // Validate and handle saving logic
                    guard let text = nameTextField.text, !text.isEmpty else {
                        showToast(message: "About required")
                        return
                    }
                    
                    // Dismiss the popup and invoke callback passing the text
                    dismiss(animated: true) {
                        self.callback?(text)
                    }
            
        }else{
                   // Validate and handle saving logic
                    guard let text = nameTextField.text, !text.isEmpty else {
                        showToast(message: "Name required")
                        return
                    }
                    
                    // Dismiss the popup and invoke callback passing the text
                    dismiss(animated: true) {
                        self.callback?(text)
                    }
            
        }
        // Helper method to show toast message
            func showToast(message: String) {
                var toastStyle = ToastStyle()
                toastStyle.backgroundColor = appThemeColor.text_Weather
                self.view.makeToast(message, duration: 2.0, position: .bottom, style: toastStyle)
            }
        
        
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true){
            self.nameTextField.resignFirstResponder()
        }
    }
    
}
