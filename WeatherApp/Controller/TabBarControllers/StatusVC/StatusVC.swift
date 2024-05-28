//
//  StatusVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/05/24.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation
import SDWebImage
class StatusVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var plusStatusImgView: UIImageView!
    @IBOutlet weak var btnGreenCamera: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblRecentUpdates: UILabel!
    @IBOutlet weak var lblTapToadd: UILabel!
    @IBOutlet weak var lblMyStatus: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnMoreOptionStack: UIButton!
    @IBOutlet weak var btnSearchStack: UIButton!
    @IBOutlet weak var btnCamerastack: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var lblUpdate: UILabel!
    var videoPath = ""
    var imagePath = ""
    let userdata = getUserData()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUserData()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    func setUserData() {
            
            let imageURLString = userdata?.result?.image ?? ""
        
            if let imageURL = URL(string: imageURLString) {
                imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
            } else {
                imageView.image = UIImage(named: "placeholder")
            }
        }
    
    func setupUI()
    {
        lblUpdate.textColor = appThemeColor.CommonBlack
        lblUpdate.font = Helvetica.helvetica_bold.font(size: 24)
        
        lblStatus.textColor = appThemeColor.CommonBlack
        lblStatus.font = Helvetica.helvetica_bold.font(size: 18)
        
        lblMyStatus.textColor = appThemeColor.CommonBlack
        lblMyStatus.font = Helvetica.helvetica_semibold.font(size: 18)
        
        lblTapToadd.textColor = appThemeColor.text_LightColure
        lblTapToadd.font = Helvetica.helvetica_regular.font(size: 16)

        lblRecentUpdates.textColor = appThemeColor.CommonBlack
        lblRecentUpdates.font = Helvetica.helvetica_medium.font(size: 18)
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
    }
    
    
    
    @IBAction func addWriteStatuswithNoteAction(_ sender: Any) 
    {
        
    }
    @IBAction func cameraStackAction(_ sender: Any)
    {
        openCamera()
    }
    @IBAction func searchAction(_ sender: Any) 
    {
        
    }
    
    @IBAction func moreOptionAction(_ sender: Any) 
    {
        
    }
    
    @IBAction func opengalleryAction(_ sender: Any)
    {
       if imagePath == ""
        {
           openCamera()
    }else{
        
            let StatusStoryVC = StatusStoryVC.getInstance()
            StatusStoryVC.modalPresentationStyle = .overCurrentContext
            StatusStoryVC.userImg = userdata?.result?.image ?? ""
            StatusStoryVC.userName = userdata?.result?.name ?? ""
            StatusStoryVC.showTabBar = {
                self.showTabBar(animated: true)
           }
            self.hideTabBar(animated: true)
            self.present(StatusStoryVC, animated: true)
        
       }
    }
    @IBAction func greenCameraAction(_ sender: Any) 
    {
        openCamera()
    }
}
extension StatusVC {
    // MARK: - Camera Picker
    func openCamera() {
        let actionSheet = UIAlertController(title: "Select Media", message: "Choose an option", preferredStyle: .actionSheet)
        
        // Camera for photos and videos
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo or Video", style: .default) { _ in
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.mediaTypes = ["public.image", "public.movie"]
                imagePicker.videoMaximumDuration = 60 // 30 minutes
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            actionSheet.addAction(cameraAction)
        } else {
            let cameraUnavailableAction = UIAlertAction(title: "Camera Unavailable", style: .default, handler: nil)
            actionSheet.addAction(cameraUnavailableAction)
        }
        
        // Photo library for photos and videos
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = ["public.image", "public.movie"]
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            actionSheet.addAction(photoLibraryAction)
        }
        
        // Cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }


}
extension StatusVC {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let mediaType = info[.mediaType] as? String {
            if mediaType == "public.image" {
                // Handle image selection
                if let editedImage = info[.editedImage] as? UIImage {
                    imageView.image = editedImage
                    imageView.layer.borderWidth = 2.5
                    imageView.layer.borderColor = appThemeColor.text_Weather.cgColor
                    plusStatusImgView.isHidden = true
                } else if let originalImage = info[.originalImage] as? UIImage {
                    imageView.image = originalImage
                    imageView.layer.borderWidth = 2.5
                    imageView.layer.borderColor = appThemeColor.text_Weather.cgColor
                    plusStatusImgView.isHidden = true
                }
                
                // Optionally, save the image to the documents directory and handle further
                if let selectedImage = imageView.image, let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                    if let imageURL = saveImageToDocumentsDirectory(data: imageData) {
                        // Use imageURL.path as the path to the saved image file
                        let imagePath = imageURL.path
                        self.imagePath = imagePath
                    }
                }
            } else if mediaType == "public.movie" {
                // Handle video selection
                if let videoURL = info[.mediaURL] as? URL {
                    // Display video thumbnail
                    let thumbnail = generateThumbnail(for: videoURL)
                    imageView.image = thumbnail
                    imageView.layer.borderWidth = 2.5
                    imageView.layer.borderColor = appThemeColor.text_Weather.cgColor
                    plusStatusImgView.isHidden = true
                    // Optionally, save the video to the documents directory and handle further
                    if let videoData = try? Data(contentsOf: videoURL) {
                        if let videoFileURL = saveVideoToDocumentsDirectory(data: videoData) {
                            // Use videoFileURL.path as the path to the saved video file
                            let videoPath = videoFileURL.path
                            self.videoPath = videoPath
                            imageView.layer.borderWidth = 2.5
                            imageView.layer.borderColor = appThemeColor.text_Weather.cgColor
                            plusStatusImgView.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Existing saveImageToDocumentsDirectory method
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

    // Save video to documents directory
    func saveVideoToDocumentsDirectory(data: Data) -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let videoURL = documentsDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            try data.write(to: videoURL)
            return videoURL
        } catch {
            print("Error writing video data: \(error)")
            return nil
        }
    }

    // Generate thumbnail for video
    func generateThumbnail(for url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 1, preferredTimescale: 60)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
}

extension StatusVC
{
    func hideTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            _ = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height
            }
        }
    }
    
    func showTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            let tabBarHeight = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height - tabBarHeight
            }
        }
    }
}
