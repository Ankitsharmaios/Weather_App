//
//  ContactDetailVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/06/24.
//

import UIKit
import SDWebImage
class ContactDetailVC: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var stackCallVideoView: UIStackView!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var viewAudio: UIView!
    @IBOutlet weak var lblAudio: UILabel!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var lblVideo: UILabel!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblMediaanddoc: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var lblNoGroupsin: UILabel!
    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var stackBlockandReportView: UIStackView!
    @IBOutlet weak var viewBlock: UIView!
    @IBOutlet weak var viewReport: UIView!
    @IBOutlet weak var lblBlock: UILabel!
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var lblReport: UILabel!
    @IBOutlet weak var btnReport: UIButton!
    
     var chatData: [ChatModel] = []
     var isfrom = ""
  
    class func getInstance()-> ContactDetailVC {
        return ContactDetailVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCollectionNib()
       
        registerTableNib()
        if isfrom == "InnerChat" {
            setData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setData()
    {
        lblName.text = chatData[0].receiverName ?? ""
        lblStatus.text = chatData[0].receiverabout ?? "Available"
        lblNumber.text = chatData[0].receiverphone ?? ""

        
        // Set user image
        if let imageURLStrings = chatData[0].receiverImage, !imageURLStrings.isEmpty,
           let imageURL = URL(string: imageURLStrings) {
            contactImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
        } else {
            contactImageView.image = UIImage(named: "Place_Holder")
        }
        
    }
    
    
    func setupUI()
    {
        contactImageView.layer.cornerRadius = contactImageView.frame.size.width / 2
        contactImageView.clipsToBounds = true
        
        viewAudio.layer.borderWidth = 1
        viewAudio.layer.borderColor = appThemeColor.CommonBlack.cgColor
        viewAudio.layer.cornerRadius = 8
        
        viewVideo.layer.borderWidth = 1
        viewVideo.layer.borderColor = appThemeColor.CommonBlack.cgColor
        viewVideo.layer.cornerRadius = 8
        
        
        lblName.font = Helvetica.helvetica_regular.font(size: 20)
        lblName.textColor = appThemeColor.CommonBlack
        
        lblNumber.font = Helvetica.helvetica_regular.font(size: 18)
        lblNumber.textColor = appThemeColor.text_LightColure
        
        lblLastSeen.font = Helvetica.helvetica_regular.font(size: 18)
        lblLastSeen.textColor = appThemeColor.text_LightColure
        
        lblStatus.font = Helvetica.helvetica_regular.font(size: 18)
        lblStatus.textColor = appThemeColor.CommonBlack
        
        lblMediaanddoc.font = Helvetica.helvetica_medium.font(size: 18)
        lblMediaanddoc.textColor = appThemeColor.text_LightColure
        
        lblNoGroupsin.font = Helvetica.helvetica_medium.font(size: 18)
        lblNoGroupsin.textColor = appThemeColor.text_LightColure
        
        lblAudio.font = Helvetica.helvetica_regular.font(size: 17)
        lblAudio.textColor = appThemeColor.CommonBlack
        
        lblVideo.font = Helvetica.helvetica_regular.font(size: 17)
        lblVideo.textColor = appThemeColor.CommonBlack
       
        
    }
    
    
    
    func registerTableNib()
    {
        groupsTableView.register(UINib(nibName: "ContactGroupTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactGroupTableViewCell")
        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        groupsTableView.separatorStyle = .none
        groupsTableView.showsVerticalScrollIndicator = false
        
    }
    
    
    func registerCollectionNib()
    {
        
        mediaCollectionView.register(UINib(nibName: "ContactMediaColletionCell", bundle: nil), forCellWithReuseIdentifier: "ContactMediaColletionCell")
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        
    }
    
    
    
    @IBAction func moreOptionAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func audioAction(_ sender: Any) {
    }
    @IBAction func videoAction(_ sender: Any) {
    }
    
    @IBAction func blockAction(_ sender: Any) {
    }
    @IBAction func reportAction(_ sender: Any) {
    }
    
}
extension ContactDetailVC:UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "ContactMediaColletionCell", for: indexPath) as! ContactMediaColletionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
}
extension ContactDetailVC:UITableViewDataSource & UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "ContactGroupTableViewCell", for: indexPath) as! ContactGroupTableViewCell
        cell.lblCreateGroupwith.text = "Create Group with \(chatData[0].receiverName ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
