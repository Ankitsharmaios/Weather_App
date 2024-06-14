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
import Alamofire
import WhatsappStatusRingBar

class StatusVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var lblTextStatus: UILabel!
    @IBOutlet weak var topTableViewWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var btnStatusprivacy: UIButton!
    @IBOutlet weak var btnTextStatus: UIButton!
    @IBOutlet weak var imageInnerView: WhatsappStatusRingBar!
    @IBOutlet weak var toptableView: UITableView!
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
    var OptionNames = [["Settings"], ["Status Privacy"]]
    var istab = false
    var contactStoryCount = 0
    var myStoryCount = 0
    var isseen = false
    var myStories: [StoryResultModel] = []
    var contactStories: [StoryResultModel] = []
    var isTopTableHide = false

    var StoryListData:StoryListModel?
    var videoPath = ""
    var imagePath = ""
    let userdata = getUserData()
    var statusTime = ""
    
    var callback:((Int) -> Void )?
    
    
    var selectedIndexPath: IndexPath?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNIb()
        toptableView.isHidden = true
        self.isTopTableHide = false
        navigationController?.navigationBar.isHidden = true
  
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        StoryList()
        let timer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            self.removeExpiredStories()
        }

        timer.invalidate()

    }
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.toptableView.isHidden = true
        
    }
    
    func setUserData() {
        if myStoryCount > 0 {
            let statusTimes = myStories.flatMap { $0.media?.compactMap { $0.time } ?? [] }
            let statusDates = myStories.flatMap { $0.media?.compactMap { $0.date } ?? [] }
            
            if let lastStatusTimeString = statusTimes.last, let statusDateString = statusDates.last {
                // Calculate time difference and set it to the label
                let elapsedTimeString = Converter.timeAgo(Date: statusDateString, Time: lastStatusTimeString)
                lblTapToadd.text = elapsedTimeString
            }

            // Assuming `myStories` is an array of `StoryResult` objects
            let mediaItems = myStories.flatMap { $0.media ?? [] }
            let imageURLStrings = mediaItems.compactMap { $0.uRL }
            
            if let lastImageURLString = imageURLStrings.last {
                if lastImageURLString.isEmpty {
                    // If the last URL is an empty string, set the background color
                    if let lastMediaItem = mediaItems.last, let backgroundColorString = lastMediaItem.textBackground, let backgroundColor = UIColor(hex: backgroundColorString) {
                        imageView.backgroundColor = backgroundColor
                        lblTextStatus.isHidden = false
                        if let text = mediaItems.compactMap({ $0.text }).last {
                            lblTextStatus.text = text.truncated(wordsLimit: 2)
                        } else {
                            lblTextStatus.text = ""
                        }
                    } else {
                        imageView.backgroundColor = .clear // Default color if no background color is specified
                    }
                    imageView.image = nil
                } else {
                    // Otherwise, set the image as usual
                    if let imageURL = URL(string: lastImageURLString) {
                        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
                    } else {
                        imageView.image = UIImage(named: "placeholder")
                    }
                    imageView.backgroundColor = .clear // Reset background color
                    lblTextStatus.isHidden = true
                }
            } else {
                imageView.image = UIImage(named: "placeholder")
                imageView.backgroundColor = .clear // Reset background color
                lblTextStatus.isHidden = true
            }

            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = appThemeColor.white.cgColor
            plusStatusImgView.isHidden = true

        } else {
            let imageURLString = userdata?.result?.image ?? ""
            
            if let imageURL = URL(string: imageURLString) {
                imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
                plusStatusImgView.isHidden = false
            } else {
                imageView.image = UIImage(named: "placeholder")
                plusStatusImgView.isHidden = false
            }
        }
    }

    func removeExpiredStories() {
        let currentTime = Date()
        let twentyFourHoursAgo = Calendar.current.date(byAdding: .hour, value: -24, to: currentTime)!
        
        myStories = myStories.filter { story in
            // Check if date and time are not nil
            guard let date = story.media?.first?.date,
                  let time = story.media?.first?.time else {
                return false // Skip if date or time is nil
            }
            
            // Combine the date and time strings into a single string in a format like "dd-MM-yyyy,HH:mm"
            let dateTimeString = "\(date),\(time)"
            
            // Convert the combined date and time string to Date
            guard let storyDateTime = dateTimeString.toDate(format: "dd MMM yyyy,HH:mm") else {
                return false // Skip if unable to convert to Date
            }
            
            // Return true if the story is not older than 24 hours
            return storyDateTime > twentyFourHoursAgo
        }
    }


    
    func registerNIb()
    {
        toptableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil), forCellReuseIdentifier: "optionHeaderTblvCell")
        tableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "StoryTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        toptableView.dataSource = self
        toptableView.delegate = self
        toptableView.separatorStyle = .none
        toptableView.layer.cornerRadius = 8
        toptableView.layer.masksToBounds = false
        toptableView.addShadowToTableView(view: toptableView, value: 2)
    }
     
    func setupUI()
    {
        
        lblTextStatus.isHidden = true
        
        lblUpdate.textColor = appThemeColor.CommonBlack
        lblUpdate.font = Helvetica.helvetica_regular.font(size: 24)
        
        lblStatus.textColor = appThemeColor.CommonBlack
        lblStatus.font = Helvetica.helvetica_medium.font(size: 18)
        
        lblMyStatus.textColor = appThemeColor.CommonBlack
        lblMyStatus.font = Helvetica.helvetica_semibold.font(size: 16)
        
        lblTapToadd.textColor = appThemeColor.text_LightColure
        lblTapToadd.font = Helvetica.helvetica_regular.font(size: 15)
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
        imageInnerView.layer.cornerRadius = imageInnerView.frame.size.width / 2
        imageInnerView.clipsToBounds = true
        
        plusStatusImgView.layer.cornerRadius = plusStatusImgView.frame.size.width / 2
        plusStatusImgView.clipsToBounds = true
        
        plusStatusImgView.layer.borderWidth = 2
        plusStatusImgView.layer.borderColor = appThemeColor.white.cgColor
        
        
        
    }
    
    
    @IBAction func statusprivacyAction(_ sender: Any)
    {
        
           istab = true
           isTopTableHide.toggle()
           toptableView.isHidden = !isTopTableHide
           topTableViewWidthLayout.constant = 140
           toptableView.reloadData()
    }
    
    @IBAction func addWriteStatuswithNoteAction(_ sender: Any) 
    {
        
        let TextStatusVC = TextStatusVC.GetInstance()
        TextStatusVC.modalPresentationStyle = .overCurrentContext
    
        TextStatusVC.showTabBar = {
            self.showTabBar(animated: true)
        }
        TextStatusVC.callback = {
            self.StoryList()
        }
        
        self.hideTabBar(animated: true)
        self.present(TextStatusVC, animated: true)
        
        
        
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
        istab = false
        isTopTableHide.toggle()
        toptableView.isHidden = !isTopTableHide
        topTableViewWidthLayout.constant = 90
        toptableView.reloadData()
    }
    
    @IBAction func opengalleryAction(_ sender: Any)
    {
        if !imagePath.isEmpty || !videoPath.isEmpty || !myStories.isEmpty {
            let MyStatusDeleteVC = MyStatusDeleteVC.getInstance()
            MyStatusDeleteVC.modalPresentationStyle = .overCurrentContext
            MyStatusDeleteVC.showTabBar = {
                   
                    self.showTabBar(animated: true)
                    self.StoryList()
            }
            MyStatusDeleteVC.myStorys = StoryListData?.result 
            self.hideTabBar(animated: true)
            self.present(MyStatusDeleteVC, animated: true)
            } else {
                openCamera()
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
        picker.dismiss(animated: true)
        let currentTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy,hh:mm"
        dateFormatter.timeZone = TimeZone.current
        let localDateTime = dateFormatter.string(from: currentTime)
        print("Local Date and Time:", localDateTime)

        // Extracting Date and Time separately if needed
        let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: currentTime)
        if let day = components.day, let month = components.month, let year = components.year,
           let hour = components.hour, let minute = components.minute, let second = components.second {
            let localDate = "\(day) \(month) \(year)"
            let localTime = "\(hour):\(minute):\(second)"
            print("Local Date:", localDate)
            print("Local Time:", localTime)
        }

       
        if let mediaType = info[.mediaType] as? String {
            if mediaType == "public.image" {
                // Handle image selection
                if let editedImage = info[.editedImage] as? UIImage {
                    imageView.image = editedImage
                    imageView.layer.borderWidth = 1.5
                    imageView.layer.borderColor = appThemeColor.white.cgColor
                    lblTextStatus.isHidden = true
                    plusStatusImgView.isHidden = true
                } else if let originalImage = info[.originalImage] as? UIImage {
                    imageView.image = originalImage
                    imageView.layer.borderWidth = 1.5
                    imageView.layer.borderColor = appThemeColor.white.cgColor
                    lblTextStatus.isHidden = true
                    plusStatusImgView.isHidden = true
                }
                
                // Optionally, save the image to the documents directory and handle further
                if let selectedImage = imageView.image, let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                    if let imageURL = saveImageToDocumentsDirectory(data: imageData) {
                        // Use imageURL.path as the path to the saved image file
                        let imagePath = imageURL.path
                        self.imagePath = imagePath
                     
                        self.addStory(UserImage: self.imagePath, storyType: story_type.media.rawValue, Text: "", TextBackground: "", Textstyle: "") { success in
                                                   if success {
                                                       self.StoryList()
                                                   } else {
                                                       // Handle error
                                                   }
                                               }
                    }
                }
            } else if mediaType == "public.movie" {
                // Handle video selection
                if let videoURL = info[.mediaURL] as? URL {
                    // Display video thumbnail
                    let thumbnail = generateThumbnail(for: videoURL)
                    imageView.image = thumbnail
                    imageView.layer.borderWidth = 1.5
                    imageView.layer.borderColor = appThemeColor.white.cgColor
                   
                    plusStatusImgView.isHidden = true
                    lblTextStatus.isHidden = true
                    // Optionally, save the video to the documents directory and handle further
                    if let videoData = try? Data(contentsOf: videoURL) {
                        if let videoFileURL = saveVideoToDocumentsDirectory(data: videoData) {
                            // Use videoFileURL.path as the path to the saved video file
                            let videoPath = videoFileURL.path
                            self.videoPath = videoPath
                           
                            
                            self.addStory(UserImage: self.videoPath, storyType: story_type.media.rawValue, Text: "", TextBackground: "", Textstyle: "") { success in
                                                       if success {
                                                           self.StoryList()
                                                       } else {
                                                           // Handle error
                                                       }
                                                   }
                            
                            
                            imageView.layer.borderWidth = 2.5
                            imageView.layer.borderColor = appThemeColor.text_Weather.cgColor
                            plusStatusImgView.isHidden = true
                            lblTextStatus.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
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
extension StatusVC
{
    //MARK: Call Api
    func StoryList(){
        let param = ["RegisterId":"\(getString(key: userDefaultsKeys.RegisterId.rawValue))"
                     ] as [String : Any]
        
        DataManager.shared.StoryList(params: param,isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let StoryList):
                print("StoryList ", StoryList)
               
                self?.StoryListData = StoryList
                self?.processStories(storyList: StoryList)
                self?.setUserData()
                self?.setupProgressView(count: 0)
                self?.tableView.reloadData()
                self?.toptableView.reloadData()
             case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
    func processStories(storyList: StoryListModel) {
        var myStories: [StoryResultModel] = []
        var contactStories: [StoryResultModel] = []
        let id = Int(getString(key: userDefaultsKeys.RegisterId.rawValue))
        guard let result = storyList.result else { return }
        
        for story in result {
            if let userId = story.userId, userId == id {
                myStories.append(story)
            } else {
                contactStories.append(story)
            }
        }
        
        let myStoryCount = myStories.count
        let contactStoryCount = contactStories.count
        
        self.myStoryCount = myStoryCount
        self.contactStoryCount = contactStoryCount
        self.myStories = myStories
        self.contactStories = contactStories
        
        
        print("========myStoryCount==========",myStoryCount, "========myStories=========",myStories)
        print("========contactStoryCount==========",contactStoryCount, "========contactStories=========",contactStories)
        
        
        
    }
    func setupProgressView(count:Int) {
        if let firstStory = self.myStories.first,
           let media = firstStory.media {
            
            let mediaURLs = media.compactMap { $0.uRL }
            let totalURLs = mediaURLs.count
            self.imageInnerView.total = totalURLs
            
            
        } else {
            self.imageInnerView.total = 0
        }
        
        self.imageInnerView.unseenProgressColor = appThemeColor.text_Weather
        self.imageInnerView.seenProgressColor = appThemeColor.btnLightGrey_BackGround
        self.imageInnerView.setProgress(progress: CGFloat(count))
        self.imageInnerView.lineWidth = 2.5
    }




}
extension StatusVC:UITableViewDataSource & UITableViewDelegate
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView{
            return 1
        }else if tableView == toptableView{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return contactStoryCount > 0 ? contactStoryCount : 0
        } else if tableView == toptableView {
            return istab ? OptionNames[1].count : OptionNames[0].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell") as! StoryTableViewCell
            cell.storyData = contactStories[indexPath.row]
            self.callback = { [weak self] SeenCount in
                         // Handle the data
                print("Received data: \(SeenCount)")
                cell.setupProgressView(progress: SeenCount)
                     }
            
            
            return cell
        }else if tableView == toptableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell
           
          
                let options = istab ? OptionNames[1] : OptionNames[0]
                cell?.nameLbl.text = options[indexPath.row]
            return cell!
            }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView{
            return UITableView.automaticDimension
        }else if tableView == toptableView
        {
            return 35
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            // Deselect the row to remove the highlight
            tableView.deselectRow(at: indexPath, animated: true)
            // Retrieve the selected data
            let selectedData = contactStories[indexPath.row]
            
            let selectedMediaURLs = selectedData.media?.compactMap { $0.uRL } ?? []
            
            let statusStoryVC = StoryViewController.GetInstance()
            statusStoryVC.contactStoriesData = selectedData
            statusStoryVC.imageCollection = [selectedMediaURLs]
            statusStoryVC.modalPresentationStyle = .overCurrentContext
            
            statusStoryVC.showTabBar = {
                self.showTabBar(animated: true)
                
            }
            statusStoryVC.callback = { [weak self] SeenCount in
                         // Handle the data
                print("Received data: \(SeenCount)")
                self?.callback?(SeenCount)
                     }

            self.hideTabBar(animated: true)
            self.present(statusStoryVC, animated: false)
        }
        if tableView == toptableView {
                let options = istab ? OptionNames[1] : OptionNames[0]
                let selectedOption = options[indexPath.row]
                
                if selectedOption == "Settings" {
                    DispatchQueue.main.async {
                        let settingVC = SettingsViewController.getInstance()
                        settingVC.modalPresentationStyle = .overCurrentContext
                        settingVC.showTabbar = {
                            self.showTabBar(animated: true)
                        }
                        self.toptableView.isHidden = true
                        self.hideTabBar(animated: true)
                        self.present(settingVC, animated: true)
                    }
                }
            }
    }


}

extension StatusVC {
    // MARK: - API CALL
    func addStory(UserImage: String,storyType:String,Text:String,TextBackground:String,Textstyle:String,completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: DataManager.shared.getURL(.addStory)) else {
            print("Invalid URL")
            return
        }

        let headers: HTTPHeaders = [
            // Your additional headers, if any
        ]

        let parameters: [String: String] = [
            "RegisterId": getString(key: userDefaultsKeys.RegisterId.rawValue),
            "StoryType": storyType ,
            "Text":Text,
            "TextBackground":TextBackground,
            "Textstyle":Textstyle
       ]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }

            if let imageData = try? Data(contentsOf: URL(fileURLWithPath: UserImage)) {
                multipartFormData.append(imageData, withName: "Media", fileName: "image.png", mimeType: "image/png")
            } else {
                print("Error reading image data from file")
            }
        }, to: url, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(true)
                if let responseDictionary = value as? [String: Any],
                   let addStory = addStoryModel(JSON: responseDictionary) {
                    
                    print("Success: \(addStory)")
                    
                } else {
                    print("Failed to map response to EditProfileModel")
                }
               
            case .failure(let error):
                print("Error: \(error)")
                completion(false)
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            }
        }
    }

}
enum story_type : String {
                
            case media = "media"
            case text = "text"
            case media_text = "media_text"
}
extension String {
    // Convert a string to a Date object using a specified format
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

extension Date {
    // Convert a Date object to a string using a specified format
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
extension String {
    func truncated(wordsLimit: Int) -> String {
        let words = self.split { $0.isWhitespace }
        guard words.count > wordsLimit else {
            return self
        }
        return words.prefix(wordsLimit).joined(separator: " ")
    }
}
