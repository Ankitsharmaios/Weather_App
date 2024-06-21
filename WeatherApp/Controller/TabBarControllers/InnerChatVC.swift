//
//  InnerChatVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import FirebaseDatabase
import ObjectMapper
import Firebase
import FirebaseMessaging

class InnerChatVC: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    

    @IBOutlet weak var stackViewtrailingLayout: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var maintableView: UITableView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var topTableHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var optionTableView: UITableView!
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
    var isTableViewHide = false
    var isCollectionHide = false
    var UserName = ""
    var AttachmentNames:[String] = ["Document","Camera","Gallery","Audio","Location","Contact"]
    var optionNames:[String] = ["View Contact","Media, links, and docs","Search","Mute notifications","Disappearing messages","Wallpaper","More"]
    let placeholderText = "Message"
    var ref: DatabaseReference!
    var LastChatData:LiveChatDataModel?
    var communitiesData:CommunitiesListModel?
    
    var chatDataArray: [ChatModel] = []
    var messages = [Message]()
    var isfrom = ""
    var showTabbar : (() -> Void )?
    var contactUserData:UserResultModel?
   var pathKey = ""
    var categoriesArr:[ChatModel] = []
    class func getInstance()-> InnerChatVC {
        return InnerChatVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
       
        fetchFirebaseData()
        if LastChatData != nil
        {
            setChatData()
            
        }else if communitiesData != nil
        {
            setGroupData()
        }
        if contactUserData != nil
        {
            contactUserDataSet()
        }
        
        setupTable()
        setupUI()
  
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            scrollToLastMessage()
        }
    
    func setupTable() {
        // config tableView
        maintableView.rowHeight = UITableView.automaticDimension
        maintableView.dataSource = self
        // cell setup
        maintableView.register(UINib(nibName: "RightViewCell", bundle: nil), forCellReuseIdentifier: "RightViewCell")
        maintableView.register(UINib(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: "LeftViewCell")
     
    }
    func setupUI(){
        optionTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil),forCellReuseIdentifier: "optionHeaderTblvCell")
        bottomCollectionView.register(UINib(nibName: "AttachmentCLvCell", bundle: nil),forCellWithReuseIdentifier: "AttachmentCLvCell")
        
        
        
        optionTableView.dataSource = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        topTableHeightLayout.constant = CGFloat(CGFloat((optionNames.count)) * (40))
        optionTableView.addShadowToTableView(view: optionTableView, value: 2)
        optionTableView.separatorStyle = .none
        optionTableView.isHidden = true
        bottomCollectionView.isHidden = true
        optionTableView.layer.cornerRadius = 8
        bottomCollectionView.layer.cornerRadius = 8
        optionTableView.reloadData()
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
        
        func textViewDidChange(_ textView: UITextView) {
            // Check if the text view is empty and show the camera button accordingly
            if textView.text.isEmpty {
                micBtn.setImage(UIImage(named: "Mic"), for: .normal)
             //   cameraBtn.isHidden = false
            } else {
                micBtn.setImage(UIImage(named: "Send"), for: .normal)
            //    cameraBtn.isHidden = true
            }
        }
    
 
    func fetchData() {
        // Sort chatDataArray by indexId or any other timestamp field
        chatDataArray.sort { $0.indexId ?? "" < $1.indexId ?? "" }
        
        // Map sorted chatDataArray to messages
        messages = chatDataArray.map { chatModel in
            let currentUserID = getString(key: userDefaultsKeys.RegisterId.rawValue)
            
            if chatModel.receiverID == currentUserID {
                // Messages sent by the current logged-in user
                return Message(text: chatModel.message ?? "", side: .left)
            } else {
                // Messages sent by others
                return Message(text: chatModel.message ?? "", side: .right)
            }
        }
        
        DispatchQueue.main.async {
            self.maintableView.reloadData()
            self.scrollToLastMessage()
        }
    }
    func scrollToLastMessage() {
            guard !messages.isEmpty else { return }
            
            let lastIndexPath = IndexPath(row: messages.count - 1, section: 0)
            maintableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
        }
    func setChatData()
    {
       
        vcallBtn.isHidden = false
        callBtn.isHidden = false
        stackViewWidthLayout.constant = 115
        userImageView.layer.cornerRadius = userImageView.layer.bounds.height / 2
        nameLbl.text = LastChatData?.senderName ?? ""
    
        let imageURLStrings = LastChatData?.senderImage

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
    }
    func contactUserDataSet()
    {
        vcallBtn.isHidden = false
        callBtn.isHidden = false
        stackViewWidthLayout.constant = 115
        userImageView.layer.cornerRadius = userImageView.layer.bounds.height / 2
        nameLbl.text = contactUserData?.name ?? ""
    
        let imageURLStrings = contactUserData?.image

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
    }
    func setGroupData()
    {
        vcallBtn.isHidden = true
        callBtn.isHidden = true
        stackViewWidthLayout.constant = 25
        userImageView.layer.cornerRadius = 10
        nameLbl.text = communitiesData?.groupName ?? ""
    
        let imageURLStrings = communitiesData?.groupIcon

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
    }
    
    @IBAction func sendMgsAction(_ sender: Any) 
    {
        // Fetch current date and time
           let currentDate = Date()
           let dateFormatter = DateFormatter()
           
           // Date format for "20-06-2024"
           dateFormatter.dateFormat = "dd-MM-yyyy"
           let presentDate = dateFormatter.string(from: currentDate)
           
           // Date format for "11:31:14"
           dateFormatter.dateFormat = "hh:mm:ss"
           let presentTime = dateFormatter.string(from: currentDate)
           
           guard let text = textView.text, !text.isEmpty else {
               print("Text field is empty")
               return
           }
           
           guard let chatRoomId = LastChatData?.id else {
               print("Chat room ID is nil")
               return
           }
           
           // Generate a unique key for each path
           let chatPathKey = ref.child("Chat").child(chatRoomId).childByAutoId().key ?? ""
           let LastChatPathKey = ref.child("LastChat").child(chatRoomId).childByAutoId().key ?? ""
           
           let userData = getUserData()
           
           // Create a dictionary to hold the data
           let data: [String: Any] = [
               "attachmentUploadFrom":"",
               "date": presentDate,
               "deleted":"",
               "id":"\(LastChatData?.id ?? "")",
               "indexId": chatPathKey,
               "mediatype":"M",
               "mediaurl":"",
               "message": text,
               "messageStatus":"",
               "receiverID":"\(LastChatData?.sentID ?? "")",
               "receiverImage":"\(LastChatData?.senderImage ?? "")",
               "receiverName":"\(LastChatData?.senderName ?? "")",
               "receiverToken":"\(LastChatData?.senderFcmToken ?? "")",
               "replyMessage":"",
               "replySendUserId":"\(getString(key: userDefaultsKeys.RegisterId.rawValue))",
               "sendType":"Send",
               "senderFcmToken":"\(AppSetting.FCMTokenString)",
               "senderImage":"\(userData?.result?.image ?? "")",
               "senderName":"\(userData?.result?.name ?? "")",
               "sentID":"\(getString(key: userDefaultsKeys.RegisterId.rawValue))",
               "time": presentTime,
               "unReadMessageCount":"1"
           ]
           
           // Post data to Firebase under the Chat path
           let chatPath = ref.child("Chat").child(chatRoomId).child(chatPathKey)
           chatPath.setValue(data) { error, ref in
               if let error = error {
                   print("Error posting data to Chat path: \(error.localizedDescription)")
               } else {
                   print("Data posted successfully to Chat path")
               }
           }
           
           // Post data to Firebase under the Messages path
           let messagesPath = ref.child("LastChat").child(chatRoomId).child(LastChatPathKey)
           messagesPath.setValue(data) { error, ref in
               if let error = error {
                   print("Error posting data to Messages path: \(error.localizedDescription)")
               } else {
                   self.textView.text = ""
                   print("Data posted successfully to Messages path")
               }
           }
    }
        
            
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        if isfrom == "SelectContect" {
            
            NotificationCenter.default.post(name: Notification.Name("dismiss"), object: nil)
            self.dismiss(animated: true)
           } else {
               self.dismiss(animated: true)
           }
    }
    
    @IBAction func clipsBtn(_ sender: Any) {
        isCollectionHide.toggle()
        if isCollectionHide == true{
            bottomCollectionView.isHidden = false
        }else{
            bottomCollectionView.isHidden = true
        }
    }
    @IBAction func cameraBtn(_ sender: Any) {
        openCamera()
    }
    @IBAction func optionBtn(_ sender: Any) {
        self.isTableViewHide.toggle()
        if isTableViewHide == true{
            self.optionTableView.isHidden = false
        }else{
            self.optionTableView.isHidden = true
        }
    }
    
  
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
// MARK: Tableview Methods
extension InnerChatVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if optionTableView == tableView
        {
            return optionNames.count
        }else if maintableView == tableView
        {
            return messages.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if optionTableView == tableView {
            if let cell = optionTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell {
                cell.nameLbl.text = optionNames[indexPath.row]
                return cell
            }
        } else if maintableView == tableView {
            let message = messages[indexPath.row]
            if message.side == .left {
                let cell = maintableView.dequeueReusableCell(withIdentifier: "LeftViewCell") as! LeftViewCell
                cell.configureCell(message: message)
                return cell
            } else {
                let cell = maintableView.dequeueReusableCell(withIdentifier: "RightViewCell") as! RightViewCell
                cell.configureCell(message: message)
                return cell
            }
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
// MARK: CollectionView Methods
extension InnerChatVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = bottomCollectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCLvCell", for: indexPath) as? AttachmentCLvCell{
            cell.namesLbl.text = AttachmentNames[indexPath.row]
            cell.imageview.image = UIImage(named: AttachmentNames[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bottomCollectionView.frame.width / 3.2, height: bottomCollectionView.frame.height / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
}

extension InnerChatVC {
    // MARK: Firebase Data Method LastChat
       func fetchFirebaseData() {
           ref = Database.database().reference()
           ref.child(firebaseTableName.Chat.rawValue).observe(.value, with: { [weak self] (snapshot) in
               guard let self = self else { return }

               guard snapshot.exists(), let userDict = snapshot.value as? [String: Any] else {
                   print("No data available or data format is incorrect")
                   return
               }

               self.chatDataArray.removeAll() // Clear the array before adding new data

               // Iterate through each child node in userDict
               for (key, value) in userDict {
                   guard let itemDict = value as? [String: Any] else {
                       print("Failed to parse item dictionary for key: \(key)")
                       continue
                   }

                   print("Key:", key)

                   // Iterate through each key-value pair in itemDict
                   for (nestedKey, nestedValue) in itemDict {
                       print("Nested Key:", nestedKey)
                       print("Nested Value:", nestedValue)

                       if let nestedValueDict = nestedValue as? [String: Any] {
                           // Access specific fields like receiverName within the nested dictionary
                           let attachmentUploadFrom = nestedValueDict["attachmentUploadFrom"] as? String ?? ""
                           let date = nestedValueDict["date"] as? String ?? ""
                           let deleted = nestedValueDict["deleted"] as? String ?? ""
                           let id = nestedValueDict["id"] as? String ?? ""
                           let indexId = nestedValueDict["indexId"] as? String ?? ""
                           let mediatype = nestedValueDict["mediatype"] as? String ?? ""
                           let mediaurl = nestedValueDict["mediaurl"] as? String ?? ""
                           let message = nestedValueDict["message"] as? String ?? ""
                           let messageStatus = nestedValueDict["messageStatus"] as? String ?? ""
                           let receiverID = nestedValueDict["receiverID"] as? String ?? ""
                           let receiverImage = nestedValueDict["receiverImage"] as? String ?? ""
                           let receiverName = nestedValueDict["receiverName"] as? String ?? ""
                           let receiverToken = nestedValueDict["receiverToken"] as? String ?? ""
                           let replyMessage = nestedValueDict["replyMessage"] as? String ?? ""
                           let replySendUserId = nestedValueDict["replySendUserId"] as? String ?? ""
                           let sendType = nestedValueDict["sendType"] as? String ?? ""
                           let senderFcmToken = nestedValueDict["senderFcmToken"] as? String ?? ""
                           let senderImage = nestedValueDict["senderImage"] as? String ?? ""
                           let senderName = nestedValueDict["senderName"] as? String ?? ""
                           let sentID = nestedValueDict["sentID"] as? String ?? ""
                           let time = nestedValueDict["time"] as? String ?? ""
                           let unReadMessageCount = nestedValueDict["unReadMessageCount"] as? String ?? ""
                           let videoCallLink = nestedValueDict["videoCallLink"] as? String ?? ""
                           let videoCallStatus = nestedValueDict["videoCallStatus"] as? String ?? ""


                           // Create a dictionary for ChatModel
                           let tempDic: [String: String] = [
                               "attachmentUploadFrom": attachmentUploadFrom,
                               "date": date,
                               "deleted": deleted,
                               "id": id,
                               "indexId": indexId,
                               "mediatype": mediatype,
                               "mediaurl": mediaurl,
                               "message": message,
                               "messageStatus": messageStatus,
                               "receiverID": receiverID,
                               "receiverImage": receiverImage,
                               "receiverName": receiverName,
                               "receiverToken": receiverToken,
                               "replyMessage": replyMessage,
                               "replySendUserId": replySendUserId,
                               "sendType": sendType,
                               "senderFcmToken": senderFcmToken,
                               "senderImage": senderImage,
                               "senderName": senderName,
                               "sentID": sentID,
                               "time": time,
                               "unReadMessageCount": unReadMessageCount,
                               "videoCallLink": videoCallLink,
                               "videoCallStatus": videoCallStatus
                           ]

                           // Check if the id matches lastChatdataId and create ChatModel instance
                           if id == LastChatData?.id, let chatModel = ChatModel(JSON: tempDic) {
                               self.chatDataArray.append(chatModel)
                           } else {
                               print("ID does not match or failed to initialize ChatModel with dictionary:")
                           }
                       }
                   }
               }

               // Reload UI on the main thread if needed
               DispatchQueue.main.async {
                   self.fetchData()
                   self.maintableView.reloadData()
                   
                   print("=====self.chatDataArray=====>",self.LastChatData?.id ?? "",self.chatDataArray.count)
               }
           }) { (error) in
               print("Error in fetching from firebase:", error.localizedDescription)
               // Handle error or retry fetching if needed
           }
       }
   }


