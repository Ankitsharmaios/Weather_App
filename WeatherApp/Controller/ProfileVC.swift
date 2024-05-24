//
//  ProfileVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import UIKit
import Foundation
import UniformTypeIdentifiers
class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var typeyourNameTextField: UITextField!
    @IBOutlet weak var btnSmiley: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblProfileInfo: UILabel!
    @IBOutlet weak var lblPleaseProvide: UILabel!
    @IBOutlet weak var nameGreenLineView: UIView!
    
    
    let imagePicker = UIImagePickerController()
    
    class func getInstance()-> ProfileVC {
        return ProfileVC.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        lblProfileInfo.font = Helvetica.helvetica_bold.font(size: 18)
        lblProfileInfo.textColor = appThemeColor.selectedCityColure
        
   //   lblPleaseProvide.font = Helvetica.helvetica_medium.font(size: 12)
        lblPleaseProvide.textColor = appThemeColor.text_LightColure
        
        btnNext.setTitleColor(appThemeColor.white, for: .normal)
        btnNext.titleLabel?.backgroundColor = appThemeColor.selectedCityColure
        
        btnNext.layer.cornerRadius = btnNext.frame.size.height / 2
        btnNext.clipsToBounds = true
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
        nameGreenLineView.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        
        imagePicker.delegate = self
    }
    
    
    
    @IBAction func smileyAction(_ sender: Any)
    {
        
    }
    
    @IBAction func moreOptionAction(_ sender: Any)
    {
        
    }
    @IBAction func nectAction(_ sender: Any) 
    {
        
    }
   
    @IBAction func gelleryAction(_ sender: Any)
    {
        openImagePicker()
    }
    
}
extension ProfileVC
{
    //MARK: - Image Picker
    func openImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true, completion: nil)
        }

        // Implement the delegate methods if needed
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                // Use the selected image
                imageView.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
   
}
