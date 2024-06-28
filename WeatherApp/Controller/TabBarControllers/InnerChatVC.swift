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
import iRecordView
import MGSwipeTableCell
import MapKit
import CoreLocation
import Alamofire
import UniformTypeIdentifiers
class InnerChatVC: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate & RecordViewDelegate & CLLocationManagerDelegate & MKMapViewDelegate & UIDocumentPickerDelegate {
    

    @IBOutlet weak var btnContactDetail: UIButton!
    @IBOutlet weak var btnMOreOption: UIButton!
    @IBOutlet weak var btnMessageForward: UIButton!
    @IBOutlet weak var btnMessageCopy: UIButton!
    @IBOutlet weak var btnMessageDelete: UIButton!
    @IBOutlet weak var lblSelectedMsgCount: UILabel!
    @IBOutlet weak var viewInnerBackBtn: UIButton!
    @IBOutlet weak var topHideShowView: UIView!
    @IBOutlet weak var stackViewtrailingLayout: NSLayoutConstraint!
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
  
    var longPressedIndexPath: IndexPath?
    private var selectedMessages: Set<IndexPath> = [] // Track selected messages

    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var imagePath = ""
    var chatDataArray: [ChatModel] = []
    var messages = [Message]()
    var isfrom = ""
    var customID = ""
    var showTabbar : (() -> Void )?
    var contactUserData:UserResultModel?
    var pathKey = ""
    var categoriesArr:[ChatModel] = []
    
    var recordButton:RecordButton!
    var recordView:RecordView!
    var stateLabel:UILabel!
    
    
    class func getInstance()-> InnerChatVC {
        return InnerChatVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
//        let recordButton = RecordButton()
//        recordButton.translatesAutoresizingMaskIntoConstraints = false
//        recordButton.tintColor = .clear
//        let recordView = RecordView()
//        recordView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(recordButton)
//        view.addSubview(recordView)
//
//        recordButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
//        recordButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
//
//        recordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
//        recordButton.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 10).isActive = true
//        
//
//        recordView.trailingAnchor.constraint(equalTo: recordButton.leadingAnchor, constant: -20).isActive = true
//        recordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        recordView.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor).isActive = true
//        recordButton.recordView = recordView
//
//        recordView.delegate = self
//        
        
        
        
        
        ref = Database.database().reference()
       
        fetchFirebaseData()
      
        
        topHideShowView.isHidden = true
        
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
        maintableView.delegate = self
        // cell setup
        maintableView.register(UINib(nibName: "RightViewCell", bundle: nil), forCellReuseIdentifier: "RightViewCell")
        maintableView.register(UINib(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: "LeftViewCell")
        maintableView.register(UINib(nibName: "rightImgVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "rightImgVideoTableViewCell")
        maintableView.register(UINib(nibName: "LeftImgVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftImgVideoTableViewCell")
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
                return Message(time: chatModel.time ?? "", text: chatModel.message ?? "", side: .left, mediaURL: chatModel.mediaurl ?? "")
            } else {
                // Messages sent by others
                return Message(time: chatModel.time ?? "", text: chatModel.message ?? "", side: .right, mediaURL: chatModel.mediaurl ?? "")
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
    func setChatData() {
        vcallBtn.isHidden = false
        callBtn.isHidden = false
        // stackViewWidthLayout.constant = 115  // Uncomment if you need to adjust stack view width
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        
        // Safely unwrap LastChatData and set values
        if let selectedChat = LastChatData {
            let userId = getString(key: userDefaultsKeys.RegisterId.rawValue)
            let isReceiver = selectedChat.receiverID == userId
            
            let receiverName = (selectedChat.receiverName ?? "").isEmpty ? selectedChat.receiverID : selectedChat.receiverName!
            let senderName = (selectedChat.senderName ?? "").isEmpty ? selectedChat.sentID : selectedChat.senderName!
            
            // Set user name
            nameLbl.text = isReceiver ? senderName : receiverName
            
            // Load user image using SDWebImage
            let imageURLString = isReceiver ? selectedChat.senderImage : selectedChat.receiverImage
            if let imageURL = URL(string: imageURLString ?? "") {
                userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
            } else {
                userImageView.image = UIImage(named: "Place_Holder")
            }
        }
    }

    func contactUserDataSet()
    {
        vcallBtn.isHidden = false
        callBtn.isHidden = false
    //    stackViewWidthLayout.constant = 115
        userImageView.layer.cornerRadius = userImageView.layer.bounds.height / 2
        nameLbl.text = contactUserData?.name ?? ""
    
        let imageURLStrings = contactUserData?.image

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "Place_Holder")
        }
    }
    func setGroupData()
    {
        vcallBtn.isHidden = true
        callBtn.isHidden = true
    //    stackViewWidthLayout.constant = 25
        userImageView.layer.cornerRadius = 10
        nameLbl.text = communitiesData?.groupName ?? ""
    
        let imageURLStrings = communitiesData?.groupIcon

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "Place_Holder")
        }
    }
    
    @IBAction func contactDetailAction(_ sender: Any) 
    {
        DispatchQueue.main.async {
            let ContactDetailVc = ContactDetailVC.getInstance()
            ContactDetailVc.chatData = self.chatDataArray
            ContactDetailVc.isfrom = "InnerChat"
            ContactDetailVc.modalPresentationStyle = .overCurrentContext
            self.present(ContactDetailVc, animated: true)
        }
    }
    @IBAction func viewInnerBackAction(_ sender: Any)
    {
        // Hide all green views and clear selection
           for indexPath in selectedMessages {
               if let rightCell = maintableView.cellForRow(at: indexPath) as? RightViewCell {
                   rightCell.greenView.isHidden = true
               } else if let leftCell = maintableView.cellForRow(at: indexPath) as? LeftViewCell {
                   leftCell.greenView.isHidden = true
               }
           }
           
           selectedMessages.removeAll()
           updateSelectedCountLabel() // Update count label
           
           // Hide topHideShowView if needed
           topHideShowView.isHidden = true
           
          
    }
    
    @IBAction func moreOptionAction(_ sender: Any) {
    }
    
    
    @IBAction func messageForwardAction(_ sender: Any) {
    }
    @IBAction func messageCopyAction(_ sender: Any) {
    }
    @IBAction func messageDeleteAction(_ sender: Any) 
    {
        let lastChatId = LastChatData?.id ?? ""
        let indexId = LastChatData?.indexId ?? ""
        let status = "yes" // Update with your desired status ("yes" or
        // Call the function to create a new entry under "Chat" table
        updateOrInsertChatEntry(lastChatId: lastChatId, indexId: indexId, status: status)
        
        
    }
    // Function to update or create a new entry under "Chat" table
    func updateOrInsertChatEntry(lastChatId: String, indexId: String, status: String) {
        guard status == "yes" || status == "no" else {
            print("Invalid status value. Use 'yes' or 'no'.")
            return
        }

        let ref = Database.database().reference()
        let chatPathRef = ref.child("Chat").child(lastChatId).child(indexId) // Use indexId as parent and lastChatId as child

        let data = [
            "deleted": status
        ] as [String : Any]

        chatPathRef.updateChildValues(data) { error, _ in
            if let error = error {
                print("Error updating entry for \(lastChatId) under \(indexId): \(error.localizedDescription)")
            } else {
                print("Entry updated successfully for \(lastChatId) under \(indexId)!")
                
            }
        }
    }
    
    
    
    @IBAction func sendMgsAction(_ sender: Any)
    {
        guard let text = textView.text, !text.isEmpty else {
               print("Text field is empty")
               return
           }

           

           let userData = getUserData()
           
           // Check if sentID is not empty
           let sentID = getString(key: userDefaultsKeys.RegisterId.rawValue)
           if sentID.isEmpty {
               print("Required data is missing")
               return
           }

           if let LastChatData = LastChatData {
               
               guard let chatRoomId = LastChatData.id else {
                   print("Chat room ID is nil")
                   return
               }
               
               let userId = getString(key: userDefaultsKeys.RegisterId.rawValue)
               let isReceiver = LastChatData.receiverID == userId
                              
               let imageURLString = isReceiver ? LastChatData.senderImage : LastChatData.receiverImage
            
               
               // Ensure that all required data is available
               guard let receiverID = LastChatData.receiverID,
                     let receiverImage = imageURLString,
                     let receiverName = self.nameLbl.text,
                     let receiverToken = LastChatData.senderFcmToken,
                     let receiverphone = LastChatData.receiverphone,
                     let receiverabout = LastChatData.receiverabout,
                     let sentabout = userData?.result?.about,
                     let sentphone = userData?.result?.phoneNo,
                     let senderImage = userData?.result?.image,
                     let senderName = userData?.result?.name else {
                   print("Required data is missing")
                   return
               }
               
               // Call the refactored function with the parameters
               sendMessage(chatRoomId: chatRoomId,
                           message: text,
                           receiverphone: receiverphone, // Convert Int to String
                           receiverabout: receiverabout,
                           receiverID: String(receiverID),
                           receiverImage: receiverImage,
                           receiverName: receiverName,
                           receiverToken: receiverToken,
                           sentphone: sentphone,
                           sentabout:sentabout,
                           senderImage: senderImage,
                           senderName: senderName,
                           senderFcmToken: AppSetting.FCMTokenString,
                           sentID: sentID,
                           mediatype: "T",
                           mediaurl: ""
               )
           }
           
           if let contactUserData = contactUserData {
               // Ensure that all required data is available
               guard let receiverID = contactUserData.id,
                     
                     let receiverImage = contactUserData.image,
                     let receiverName = contactUserData.name,
                     let receiverToken = contactUserData.deviceToken,
                     let receiverphone = contactUserData.phoneno,
                     let receiverabout = contactUserData.about,
                     let sentabout = userData?.result?.about,
                     let sentphone = userData?.result?.phoneNo,
                     let senderImage = userData?.result?.image,
                     let senderName = userData?.result?.name else {
                   print("Required data is missing")
                   return
               }
               
               // Call the refactored function with the parameters
               sendMessage(chatRoomId: self.customID,
                           message: text,
                           receiverphone: receiverphone, // Convert Int to String
                           receiverabout: receiverabout,
                           receiverID: String(receiverID),
                           receiverImage: receiverImage,
                           receiverName: receiverName,
                           receiverToken: receiverToken,
                           sentphone: sentabout,
                           sentabout: sentphone,
                           senderImage: senderImage,
                           senderName: senderName,
                           senderFcmToken: AppSetting.FCMTokenString,
                           sentID: sentID,
                           mediatype: "T",
                           mediaurl: "" 
               )
           }
       
    }
        
    func sendMessage(chatRoomId: String, message: String,receiverphone:String,receiverabout:String, receiverID: String, receiverImage: String, receiverName: String, receiverToken: String,sentphone:String,sentabout:String,senderImage: String, senderName: String, senderFcmToken: String, sentID: String,mediatype:String,mediaurl:String) {
        // Fetch current date and time
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        // Date format for "20-06-2024"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let presentDate = dateFormatter.string(from: currentDate)
        
        // Date format for "11:31:14"
        dateFormatter.dateFormat = "hh:mm:ss"
        let presentTime = dateFormatter.string(from: currentDate)
        
        // Generate a unique key for each path
        let chatPathKey = ref.child("Chat").child(chatRoomId).childByAutoId().key ?? ""
       // let lastChatPathKey = ref.child("LastChat").child(chatRoomId).childByAutoId().key ?? ""
        
        // Create a dictionary to hold the data
        let data: [String: Any] = [
            "attachmentUploadFrom": "",
            "date": presentDate,
            "deleted": "",
            "id": chatRoomId,
            "indexId": chatPathKey,
            "mediatype": mediatype,
            "mediaurl": mediaurl,
            "message": message,
            "messageStatus": "",
            "receiverphone":receiverphone,
            "receiverabout":receiverabout,
            "receiverID": receiverID,
            "receiverImage": receiverImage,
            "receiverName": receiverName,
            "receiverToken": receiverToken,
            "replyMessage": "",
            "replySendUserId": sentID,
            "sentphone":sentphone,
            "sentabout":sentabout,
            "sendType": "Send",
            "senderFcmToken": senderFcmToken,
            "senderImage": senderImage,
            "senderName": senderName,
            "sentID": sentID,
            "time": presentTime,
            "unReadMessageCount": "1"
        ]
        
        // Post data to Firebase under the Chat path
        let chatPath = ref.child("Chat").child(chatRoomId).child(chatPathKey)
        chatPath.setValue(data) { error, ref in
            if let error = error {
                print("Error posting data to Chat path: \(error.localizedDescription)")
            } else {
                print("Data posted successfully to Chat path")
                
                self.fetchFirebaseData()
                self.fetchData()
            }
        }
        
        // Post data to Firebase under the LastChat path
        let messagesPath = ref.child("LastChat").child(chatRoomId)
        messagesPath.setValue(data) { error, ref in
            if let error = error {
                print("Error posting data to LastChat path: \(error.localizedDescription)")
            } else {
                self.textView.text = ""
                print("Data posted successfully to LastChat path")
                
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
            
            // Check if the message contains a media URL
            if let mediaURL = message.mediaURL, !mediaURL.isEmpty {
                if message.side == .left {
                    // Dequeue and configure LeftImgVideoTableViewCell for left media message
                    let cell = maintableView.dequeueReusableCell(withIdentifier: "LeftImgVideoTableViewCell", for: indexPath) as! LeftImgVideoTableViewCell
                    cell.configure(with: mediaURL, time: message.time)
                    cell.layer.cornerRadius = 10
                    cell.clipsToBounds = true
                    return cell
                } else {
                    // Dequeue and configure rightImgVideoTableViewCell for right media message
                    let cell = maintableView.dequeueReusableCell(withIdentifier: "rightImgVideoTableViewCell", for: indexPath) as! rightImgVideoTableViewCell
                    cell.configure(with: mediaURL, time: message.time)
                    cell.layer.cornerRadius = 10
                    cell.clipsToBounds = true
                    return cell
                }
            } else {
                // Handle text messages
                let cell: UITableViewCell
                if message.side == .left {
                    cell = maintableView.dequeueReusableCell(withIdentifier: "LeftViewCell", for: indexPath) as! LeftViewCell
                    (cell as! LeftViewCell).configureCell(message: message)
                    addLongPressGesture(to: cell, indexPath: indexPath)
                } else {
                    cell = maintableView.dequeueReusableCell(withIdentifier: "RightViewCell", for: indexPath) as! RightViewCell
                    (cell as! RightViewCell).configureCell(message: message)
                    addLongPressGesture(to: cell, indexPath: indexPath)
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }



        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if longPressedIndexPath == nil || indexPath == longPressedIndexPath {
                toggleGreenView(for: indexPath)
                longPressedIndexPath = nil
            } else {
                toggleGreenView(for: indexPath)
            }
        
        }

        func addLongPressGesture(to cell: UITableViewCell, indexPath: IndexPath) {
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longGesture.minimumPressDuration = 0.5
            cell.addGestureRecognizer(longGesture)
        }

        @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began else { return }
            guard let indexPath = maintableView.indexPathForRow(at: gesture.location(in: maintableView)) else { return }
            longPressedIndexPath = indexPath
            toggleGreenView(for: indexPath)
            topHideShowView.isHidden = false
        }

        private func toggleGreenView(for indexPath: IndexPath) {
            if let rightCell = maintableView.cellForRow(at: indexPath) as? RightViewCell {
                let isHidden = !rightCell.greenView.isHidden
                rightCell.greenView.isHidden = isHidden
                rightCell.reacionView.isHidden = isHidden
            } else if let leftCell = maintableView.cellForRow(at: indexPath) as? LeftViewCell {
                let isHidden = !leftCell.greenView.isHidden
                leftCell.greenView.isHidden = isHidden
                leftCell.reacionView.isHidden = isHidden
            }
            
            if selectedMessages.contains(indexPath) {
                selectedMessages.remove(indexPath)
            } else {
                selectedMessages.insert(indexPath)
            }
            
            updateSelectedCountLabel()
        }

        private func updateSelectedCountLabel() {
            lblSelectedMsgCount.text = "\(selectedMessages.count)"
            if selectedMessages.count == 0 {
                topHideShowView.isHidden = true
                for indexPath in selectedMessages {
                    if let rightCell = maintableView.cellForRow(at: indexPath) as? RightViewCell {
                        rightCell.greenView.isHidden = true
                        rightCell.reacionView.isHidden = true
                    } else if let leftCell = maintableView.cellForRow(at: indexPath) as? LeftViewCell {
                        leftCell.greenView.isHidden = true
                        leftCell.reacionView.isHidden = true
                    }
                }
                selectedMessages.removeAll()
            }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOption = AttachmentNames[indexPath.row]
        if selectedOption == "Contact" {
            DispatchQueue.main.async {
                let ContactVC = ContactsViewController.getInstance()
                ContactVC.modalPresentationStyle = .overCurrentContext
                ContactVC.isfrom = "Contacts to send"
             
                ContactVC.stackViewHideShow.isHidden = true
                ContactVC.stackviewHeightlayout.constant = 0
                ContactVC.view.layoutIfNeeded()
                ContactVC.updateHeaderViewHeight(newHeight: 0)
                
                ContactVC.showTabbar = {
                    self.showTabBar(animated: true)
                }
                self.bottomCollectionView.isHidden = true
                self.hideTabBar(animated: true)
                self.present(ContactVC, animated: true)
            }
        }else if selectedOption == "Camera"
        {
            self.bottomCollectionView.isHidden = true
            DispatchQueue.main.async {
                self.openCamera()
            }

        }else if selectedOption == "Gallery"
        {
            self.bottomCollectionView.isHidden = true
            DispatchQueue.main.async {
                self.openGallery()
            }

        }else if selectedOption == "Document"
        {
            self.bottomCollectionView.isHidden = true
            DispatchQueue.main.async {
                let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.plainText])
                        documentPicker.delegate = self
                        documentPicker.modalPresentationStyle = .fullScreen
                        self.present(documentPicker, animated: true, completion: nil)
            }

        }else if selectedOption == "Audio"
        {
            self.bottomCollectionView.isHidden = true
            DispatchQueue.main.async {
                let audioTypes: [UTType] = [
                                   .audio,
                                   .mp3,
                                   .mpeg4Audio,
                                   .wav,
                                   .appleProtectedMPEG4Audio
                               ]
                               
                               let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: audioTypes)
                               documentPicker.delegate = self
                               documentPicker.modalPresentationStyle = .fullScreen
                               self.present(documentPicker, animated: true, completion: nil)
                           }
            

        }else if selectedOption == "Location"
        {
            self.bottomCollectionView.isHidden = true
            DispatchQueue.main.async {
                self.openMap()
            }

        }
        
        
    }

// UIDocumentPickerDelegate methods
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        // Handle the picked document
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle the cancellation
    }

    func openMap() {
            let locationViewController = LocationViewController()
            locationViewController.modalPresentationStyle = .fullScreen
            present(locationViewController, animated: true, completion: nil)
        }
}
extension InnerChatVC {
     func openGallery() {
         if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = .photoLibrary
             imagePicker.allowsEditing = false
             present(imagePicker, animated: true, completion: nil)
         }
     }
     
    // MARK: - UIImagePickerControllerDelegate Methods
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                // Do something with the selected image
                // For example, you can set it to an UIImageView
                
            }
            
            if let imageURL = info[.imageURL] as? URL {
                // Get the image path
                let imagePath = imageURL.path
                
                self.imagePath = imagePath
                self.AddAttachment(Media: self.imagePath)
                print("Selected image path: \(imagePath)")
            }
            
            picker.dismiss(animated: true, completion: nil)
        }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
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
                           
                           if deleted.lowercased() != "yes".lowercased(){
                               // Check if the id matches lastChatdataId and create ChatModel instance
                               if id == LastChatData?.id || id == self.customID, let chatModel = ChatModel(JSON: tempDic) {
                                   self.chatDataArray.append(chatModel)
                                   
                               } else {
                                   print("ID does not match or failed to initialize ChatModel with dictionary:")
                               }
                           }
                       }
                   }
               }

               // Reload UI on the main thread if needed
               DispatchQueue.main.async {
                   self.fetchData()
                   self.maintableView.reloadData()
                   
                   print("=====self.chatDataArray=====>",self.LastChatData?.id ?? "",self.chatDataArray)
               }
           }) { (error) in
               print("Error in fetching from firebase:", error.localizedDescription)
               // Handle error or retry fetching if needed
           }
       }
   }

extension InnerChatVC
{

    func onStart() {
        openEmojiBtn.isHidden = true
        textView.isHidden = true
        bottomstackView.isHidden = true
        
        print("onStart")
    }
    
    func onCancel() {
        openEmojiBtn.isHidden = false
        textView.isHidden = false
        bottomstackView.isHidden = false
        print("onCancel")
    }
    
    func onFinished(duration: CGFloat) {
        openEmojiBtn.isHidden = false
        textView.isHidden = false
        bottomstackView.isHidden = false
        print("onFinished \(duration)")
    }
    
    func onAnimationEnd() {
        openEmojiBtn.isHidden = false
        textView.isHidden = false
        bottomstackView.isHidden = false
        print("onAnimationEnd")
    }
    
}
extension InnerChatVC
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

extension InnerChatVC {
    // MARK: - API CALL
    func AddAttachment(Media: String) {
        guard let url = URL(string: DataManager.shared.getURL(.AddAttachment)) else {
            print("Invalid URL")
            return
        }

        let headers: HTTPHeaders = [
            // Your additional headers, if any
        ]

        let parameters: [String: String] = [
            "RegisterId": "\(Singleton.sharedInstance.RegisterId ?? 0)"
        ]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }

            if let imageData = try? Data(contentsOf: URL(fileURLWithPath: Media)) {
                multipartFormData.append(imageData, withName: "Media", fileName: "image.png", mimeType: "image/png")
            } else {
                print("Error reading image data from file")
            }
        }, to: url, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let responseDictionary = value as? [String: Any],
                   let AddAttachmentModel = AddAttachmentModel(JSON: responseDictionary) {
                    print("Success: \(AddAttachmentModel)")

                    if let statusMessage = responseDictionary["StatusMessage"] as? String {
                        print("Success: \(statusMessage)")
                        DispatchQueue.main.async {
                            if statusMessage.lowercased() == "Data added successully".lowercased() {
                                let mediaLink = AddAttachmentModel.mediaLink ?? ""
                                
                                // Get file extension from mediaLink
                                let fileExtension = (mediaLink as NSString).pathExtension.lowercased()
                                
                                // Determine category based on file extension
                                var category = ""
                                switch fileExtension {
                                case "jpg", "png", "jpeg":
                                    category = "I"
                                case "pdf":
                                    category = "P"
                                case "txt":
                                    category = "T"
                                case "doc", "docx":
                                    category = "D"
                                case "mp4", "3gp", "mkv":
                                    category = "V"
                                case "csv":
                                    category = "C"
                                default:
                                    category = ""
                                }
                                
                                // Print category and mediaLink
                                print("Category: \(category), MediaLink: \(mediaLink)")
                               
                                
                                let userData = getUserData()
                                
                                // Check if sentID is not empty
                                let sentID = getString(key: userDefaultsKeys.RegisterId.rawValue)
                                if sentID.isEmpty {
                                    print("Required data is missing")
                                    return
                                }

                                if let LastChatData = self.LastChatData {
                                    
                                    guard let chatRoomId = LastChatData.id else {
                                        print("Chat room ID is nil")
                                        return
                                    }
                                    
                                    let userId = getString(key: userDefaultsKeys.RegisterId.rawValue)
                                    let isReceiver = LastChatData.receiverID == userId
                                                   
                                    let imageURLString = isReceiver ? LastChatData.senderImage : LastChatData.receiverImage
                                 
                                    
                                    // Ensure that all required data is available
                                    guard let receiverID = LastChatData.receiverID,
                                          let receiverImage = imageURLString,
                                          let receiverphone = LastChatData.receiverphone,
                                          let receiverabout = LastChatData.receiverabout,
                                          let receiverName = self.nameLbl.text,
                                          let receiverToken = LastChatData.senderFcmToken,
                                          let sentabout = userData?.result?.about,
                                          let sentphone = userData?.result?.phoneNo,
                                          let senderImage = userData?.result?.image,
                                          let senderName = userData?.result?.name else {
                                          
                                        print("Required data is missing")
                                        return
                                    }
                                    
                                    // Call the refactored function with the parameters
                                    self.sendMessage(chatRoomId: chatRoomId,
                                                message: "",
                                                receiverphone: receiverphone, // Convert Int to String
                                                receiverabout: receiverabout,
                                                receiverID: String(receiverID),
                                                receiverImage: receiverImage,
                                                receiverName: receiverName,
                                                receiverToken: receiverToken,
                                                sentphone: sentabout,
                                                sentabout: sentphone,
                                                senderImage: senderImage,
                                                senderName: senderName,
                                                senderFcmToken: AppSetting.FCMTokenString,
                                                sentID: sentID,
                                                mediatype: category,
                                                mediaurl: mediaLink
                                    )
                                }
                                
                                
                                
                                
                                
                                if let contactUserData = self.contactUserData {
                                    // Ensure that all required data is available
                                    guard let receiverID = contactUserData.id,
                                          let receiverImage = contactUserData.image,
                                          let receiverName = contactUserData.name,
                                          let receiverToken = contactUserData.deviceToken,
                                          let receiverphone = contactUserData.phoneno,
                                          let receiverabout = contactUserData.about,
                                          let sentabout = userData?.result?.about,
                                          let sentphone = userData?.result?.phoneNo,
                                          let senderImage = userData?.result?.image,
                                          let senderName = userData?.result?.name else {
                                        print("Required data is missing")
                                        return
                                    }
                                    
                                    // Call the refactored function with the parameters
                                    self.sendMessage(chatRoomId: self.customID,
                                                message: "",
                                                receiverphone: receiverphone, // Convert Int to String
                                                receiverabout: receiverabout,
                                                receiverID: String(receiverID),
                                                receiverImage: receiverImage,
                                                receiverName: receiverName,
                                                receiverToken: receiverToken,
                                                sentphone: sentabout,
                                                sentabout: sentphone,
                                                senderImage: senderImage,
                                                senderName: senderName,
                                                senderFcmToken: AppSetting.FCMTokenString,
                                                sentID: sentID,
                                                mediatype: category,
                                                mediaurl: mediaLink
                                    )
                                }
                                
                            }
                        }
                    } else {
                        print("StatusMessage not found in response")
                    }
                } else {
                    print("Failed to map response to AddAttachmentModel")
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

