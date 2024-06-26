//
//  EditProfileVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 18/06/24.
//

import UIKit
import UniformTypeIdentifiers
import Toast_Swift
import Alamofire

class EditProfileVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var btnChangeNumber: UIButton!
    @IBOutlet weak var lblSHowNumber: UILabel!
    @IBOutlet weak var lblPhoneTitle: UILabel!
    @IBOutlet weak var btnChangeAbout: UIButton!
    @IBOutlet weak var lblShowAbout: UILabel!
    @IBOutlet weak var lblAboutTitle: UILabel!
    @IBOutlet weak var btnChangeUserName: UIButton!
    @IBOutlet weak var lblThisisnot: UILabel!
    @IBOutlet weak var lblNameShow: UILabel!
    @IBOutlet weak var lblNametitle: UILabel!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var userImgaeView: UIImageView!
    @IBOutlet weak var CameraImgView: UIImageView!
    
    
    var imagePath = ""
    let imagePicker = UIImagePickerController()
    
    var callback: ((String?,String) -> Void )?
    
    class func getInstance()-> EditProfileVC {
        return EditProfileVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    var userstatus = ""
    var userNmae = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edituserData()
        setUpUI()
           NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedAboutNotification(notification:)), name: Notification.Name("aboutUpdated"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func methodOfReceivedAboutNotification(notification: Notification) {
        if let about = notification.object as? String {
            self.EditProfile(UserImage: "", name: "", about: about)
            self.userstatus = about
        }
    }
    func edituserData()
    {
        if Singleton.sharedInstance.EditProfileData?.result?.name?.count ?? 0 > 0
        {
          
            let userdata = getUserData()
            let number = userdata?.result?.phoneNo ?? ""
            lblSHowNumber.text = number
            
            let userData = Singleton.sharedInstance.EditProfileData?.result
            let name = userData?.name ?? ""
            let imageURLString = userData?.userImage ?? ""
            let about = userData?.about ?? ""
            lblNameShow.text = name
            lblShowAbout.text = about

            
            if let imageURL = URL(string: imageURLString) {
                userImgaeView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
            } else {
                userImgaeView.image = UIImage(named: "Place_Holder")
            }
        }else{
            setUserData()
        }
    }
    func setUserData() {
            let userdata = getUserData()
            let name = userdata?.result?.name ?? ""
            let imageURLString = userdata?.result?.image ?? ""
            let about = userdata?.result?.about ?? ""
            let number = userdata?.result?.phoneNo ?? ""
            
            lblNameShow.text = name
            lblShowAbout.text = about
            lblSHowNumber.text = number
        
            if let imageURL = URL(string: imageURLString) {
                userImgaeView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
            } else {
                userImgaeView.image = UIImage(named: "Place_Holder")
            }
        }
    
    
    func setUpUI()
    {
        lblProfile.font = Nunitonsans.nuniton_regular.font(size: 20)
        lblProfile.textColor = appThemeColor.CommonBlack
        
        lblNametitle.font = Nunitonsans.nuniton_regular.font(size: 11)
        lblNametitle.textColor = appThemeColor.text_LightColure
        
        lblNameShow.font = Nunitonsans.nuniton_regular.font(size: 16)
        lblNameShow.textColor = appThemeColor.CommonBlack
        
        lblThisisnot.font = Nunitonsans.nuniton_regular.font(size: 11)
        lblThisisnot.textColor = appThemeColor.text_LightColure
        
        lblAboutTitle.font = Nunitonsans.nuniton_regular.font(size: 11)
        lblAboutTitle.textColor = appThemeColor.text_LightColure
        
        lblShowAbout.font = Nunitonsans.nuniton_regular.font(size: 16)
        lblShowAbout.textColor = appThemeColor.CommonBlack
        
        lblPhoneTitle.font = Nunitonsans.nuniton_regular.font(size: 11)
        lblPhoneTitle.textColor = appThemeColor.text_LightColure
        
        lblSHowNumber.font = Nunitonsans.nuniton_regular.font(size: 15)
        lblSHowNumber.textColor = appThemeColor.CommonBlack
        
        userImgaeView.layer.cornerRadius = userImgaeView.frame.size.width / 2
        userImgaeView.clipsToBounds = true
        
        
        CameraImgView.layer.cornerRadius = CameraImgView.frame.size.width / 2
        CameraImgView.clipsToBounds = true
        
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true)
        {
            self.callback?(self.lblShowAbout.text ?? "",self.lblNameShow.text ?? "")
        }
    }
    
    @IBAction func cameraAction(_ sender: Any) 
    {
        openImagePicker()
    }
    
    @IBAction func changeUserNameAction(_ sender: Any) 
    {
        let viewController = NamePopUpVC.getInstance()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.username = lblNameShow.text ?? ""
        viewController.callback = { [weak self] name in
                    // Handle the received name here
                    print("Received name:", name)
            self?.EditProfile(UserImage: "", name: name, about: "")
                    self?.edituserData()
                }
        present(viewController, animated: true)
    }
    
    @IBAction func changeAboutAction(_ sender: Any) 
    {
        
        let viewController = AboutVC.getInstance()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.passAbout = lblShowAbout.text ?? ""
        viewController.callback = { [weak self] about in
                NotificationCenter.default.post(name: Notification.Name("aboutUpdated"), object: about)
                self?.dismiss(animated: true)
            
            }
        present(viewController, animated: true)
    }
    
    @IBAction func changeNumberAction(_ sender: Any) 
    {

    }
    
}
extension EditProfileVC: UIImagePickerControllerDelegate {
    // MARK: - Image Picker
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
            userImgaeView.image = pickedImage
            userImgaeView.contentMode = .scaleAspectFill
            
            // Convert the image to data
            if let imageData = pickedImage.jpegData(compressionQuality: 0.8) {
                // Save the image data to the documents directory and get the file URL
                if let imageURL = saveImageToDocumentsDirectory(data: imageData) {
                    // You can use imageURL.path as the path to the saved image file
                    let imagePath = imageURL.path
                    // Pass the image path to your API function
                    self.imagePath = imagePath
                    // Call the EditProfile function with the image path
                    
                    EditProfile(UserImage: imagePath, name: "", about: "")
                    
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
extension EditProfileVC {
    // MARK: - API CALL
    func EditProfile(UserImage: String,name:String,about:String) {
        guard let url = URL(string: DataManager.shared.getURL(.EditProfile)) else {
            print("Invalid URL")
            return
        }

        let headers: HTTPHeaders = [
            // Your additional headers, if any
        ]

        let parameters: [String: String] = [
            "RegisterId": getString(key: userDefaultsKeys.RegisterId.rawValue),
            "HashToken": getString(key: userDefaultsKeys.token.rawValue),
            "Name": name,
            "About": about
        ]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }

            if let imageData = try? Data(contentsOf: URL(fileURLWithPath: UserImage)) {
                multipartFormData.append(imageData, withName: "UserImage", fileName: "image.png", mimeType: "image/png")
            } else {
                print("Error reading image data from file")
            }
        }, to: url, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let responseDictionary = value as? [String: Any],
                   let editProfileModel = EditProfileModel(JSON: responseDictionary) {
                    Singleton.sharedInstance.EditProfileData = editProfileModel
    
                    print("Success: \(editProfileModel)")
                    
                    if let statusMessage = responseDictionary["StatusMessage"] as? String {
                        print("Success: \(statusMessage)")
                        DispatchQueue.main.async {
                            if statusMessage.lowercased() == "profile edit successully" {
                                self.edituserData()
                                var toastStyle = ToastStyle()
                                toastStyle.backgroundColor = appThemeColor.text_Weather
                                self.view.makeToast(editProfileModel.statusMessage ?? "", duration: 2.0, position: .bottom, style: toastStyle)
                               // removeUserDefaultsKey(key: userDefaultsKeys.userdata.rawValue)
                            }
                        }
                    } else {
                        print("StatusMessage not found in response")
                    }
                } else {
                    print("Failed to map response to EditProfileModel")
                }
            case .failure(let error):
                print("Error: \(error)")
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            }
        }
    }

}
