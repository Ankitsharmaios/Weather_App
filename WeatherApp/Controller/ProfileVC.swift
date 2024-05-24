//
//  ProfileVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//
import Toast_Swift
import UIKit
import Foundation
import UniformTypeIdentifiers
import Alamofire
class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var typeyourNameTextField: UITextField!
    @IBOutlet weak var btnSmiley: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblProfileInfo: UILabel!
    @IBOutlet weak var lblPleaseProvide: UILabel!
    @IBOutlet weak var nameGreenLineView: UIView!
    
    var EditProfileData:EditProfileModel?
    var imagePath = ""
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
        btnNext.layer.backgroundColor = appThemeColor.selectedCityColure.cgColor
        
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
    @IBAction func NextAction(_ sender: Any)
    {
        // Configure the toast style
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = appThemeColor.text_Weather
       
        
        
        // Check if the number field is empty
        if typeyourNameTextField.text?.isEmpty == true {
            // If the text field is empty, show a toast message with custom style
            self.view.makeToast("Name required", duration: 2.0, position: .bottom, style: toastStyle)
            return
        }
        
        self.view.endEditing(true)
        EditProfile(UserImage: imagePath)
        
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
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        
        }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
        
        // Get the selected image
        if let pickedImage = info[.originalImage] as? UIImage {
            // Set the image view to display the selected image
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFill
            
            // Convert the image to data
            if let imageData = pickedImage.jpegData(compressionQuality: 0.8) {
                // Save the image data to the documents directory and get the file URL
                if let imageURL = saveImageToDocumentsDirectory(data: imageData) {
                    // You can use imageURL.path as the path to the saved image file
                    let imagePath = imageURL.path
                    // Pass the image path to your API function
                    self.imagePath = imagePath
                }
            }
        }
    }

    func saveImageToDocumentsDirectory(data: Data) -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let imageURL = documentsDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            try data.write(to: imageURL)
            return imageURL
        } catch {
            print("Error writing image data: \(error)")
            return nil
        }
    }
    
}
extension ProfileVC
{
    // MARK: - API CALL
    
    func EditProfile(UserImage: String) {
        guard let url = URL(string: DataManager.shared.getURL(.EditProfile)) else { return }
        let headers: HTTPHeaders = [
            // Your additional headers, if any
        ]
           let parameters: [String: String] = [
                         "RegisterId":"\(Singleton.sharedInstance.RegisterId ?? 0)",
                         "HashToken":getString(key: userDefaultsKeys.token.rawValue),
                         "Name":self.typeyourNameTextField.text ?? "",
                         "About":""
                         
           ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }

            if let imageData = try? Data(contentsOf: URL(fileURLWithPath: UserImage)) {
                multipartFormData.append(imageData, withName: "UserImage", fileName: "image.png", mimeType: "image/png")
            }
        }, to: url, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let responseDictionary = value as? [String: Any],
                   let statusMessage = responseDictionary["StatusMessage"] as? String {
                    print("Success: \(statusMessage)")
                    DispatchQueue.main.async {
                        if statusMessage.lowercased() == "Profile Edit successully".lowercased()
                        {
                            let Two_step_verificationVC =  Two_step_verificationVC.getInstance()
                            Two_step_verificationVC.modalPresentationStyle = .overCurrentContext
                            self.present(Two_step_verificationVC, animated: true)
                        
                        }
                    }
                } else {
                    print("Failed to access StatusMessage from response")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }

       }
    
    }
