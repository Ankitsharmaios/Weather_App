//
//  InnerChatVC.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
class InnerChatVC: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var maintableView: UITableView!
    @IBOutlet weak var emojiTxt: EmojiTextField!
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
  
    var LastChatData:LiveChatDataModel?
    
    class func getInstance()-> InnerChatVC {
        return InnerChatVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupUI()
       print("=========LastChatData==========",LastChatData)
    }
 
    func setupUI(){
        optionTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil),forCellReuseIdentifier: "optionHeaderTblvCell")
        bottomCollectionView.register(UINib(nibName: "AttachmentCLvCell", bundle: nil),forCellWithReuseIdentifier: "AttachmentCLvCell")
        optionTableView.dataSource = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        topTableHeightLayout.constant = CGFloat(CGFloat((optionNames.count)) * (40))
        optionTableView.addShadowToTableView(view: optionTableView, value: 2)
    //    bottomCollectionView.addShadowToCollectionView(view: bottomCollectionView, value: 2)
        optionTableView.separatorStyle = .none
        optionTableView.isHidden = true
        bottomCollectionView.isHidden = true
        optionTableView.layer.cornerRadius = 8
        bottomCollectionView.layer.cornerRadius = 8
        optionTableView.reloadData()
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
    
    func setData()
    {
      
        nameLbl.text = LastChatData?.senderName ?? ""
        
        
        
        
        
        
        
        let imageURLStrings = LastChatData?.senderImage

        // Safely get the last URL string if it exists
        if let lastImageURLString = imageURLStrings, let imageURL = URL(string: lastImageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
    }
    
    
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
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
    
    @IBAction func emojiBtn(_ sender: Any) {
        emojiTxt.becomeFirstResponder()
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
        return optionNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = optionTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
            cell.nameLbl.text = optionNames[indexPath.row]
            return cell
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
