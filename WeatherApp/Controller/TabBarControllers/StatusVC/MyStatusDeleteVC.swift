//
//  MyStatusDeleteVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 13/06/24.
//

import UIKit

class MyStatusDeleteVC: UIViewController {

    @IBOutlet var foterView: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnTextStatus: UIButton!
    @IBOutlet weak var lblYourStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMyStatus: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableViewHeightLayout: NSLayoutConstraint!
    
    var myStorys:[StoryResultModel]?
    var showTabBar: (() -> Void )?

    let text = "Your status updates are end-to-end encrypted. They will disappear after 24 hours."

   
    class func getInstance()-> MyStatusDeleteVC {
        return MyStatusDeleteVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setNib()
        setlbl()
        print("===================myStorys->",myStorys ?? "")
      
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
         lblMyStatus.font = Helvetica.helvetica_regular.font(size: 20)
         lblMyStatus.textColor = appThemeColor.CommonBlack
         
         lblYourStatus.font = Helvetica.helvetica_regular.font(size: 10)
         lblYourStatus.textColor = appThemeColor.Gray_Colure
         
       
     }
    func setlbl()
    {
        // Create an NSMutableAttributedString from the text
        let attributedString = NSMutableAttributedString(string: self.text)

        // Define the attributes for the entire text
        let blackAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: appThemeColor.Gray_Colure,
            .font: Helvetica.helvetica_regular.font(size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        
        attributedString.addAttributes(blackAttributes, range: NSRange(location: 0, length: text.count))

        // Define the attributes for the specific part of the text you want to change color
        let greenAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: appThemeColor.text_Weather,
            .font: Helvetica.helvetica_regular.font(size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]

        // Find the range of the specific text
        let range = (text as NSString).range(of: "end-to-end encrypted.")

        // Apply the green color attributes to the specific part of the text
        attributedString.addAttributes(greenAttributes, range: range)

        // Set the attributed text to the UILabel
        lblYourStatus.attributedText = attributedString

        // Ensure the label can display multiple lines
        lblYourStatus.numberOfLines = 0
    }
    
    func setNib()
    {
        
        
        if let myStorys = myStorys, let mediaCount = myStorys.first?.media?.count {
                    if mediaCount > 8 {
                        tableViewHeightLayout.constant = 8 * 70.0
                        tableView.isScrollEnabled = true
                        tableView.showsVerticalScrollIndicator = true
                    } else {
                        tableViewHeightLayout.constant = CGFloat(mediaCount) * 70.0
                        tableView.isScrollEnabled = false
                        tableView.showsVerticalScrollIndicator = false
                    }
                }
        
        
        
        tableView.register(UINib(nibName: "MyStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "MyStatusTableViewCell")
        tableView.tableFooterView = foterView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true)
        {
            self.showTabBar?()
        }
    }
    
    @IBAction func textStoryAction(_ sender: Any) {
    }
    
    @IBAction func cameraAction(_ sender: Any) {
    }
}
extension MyStatusDeleteVC:UITableViewDataSource & UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStorys?.first?.media?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyStatusTableViewCell", for: indexPath) as? MyStatusTableViewCell else {
            return UITableViewCell()
        }

        if let mediaItems = myStorys?.first?.media {
            let mediaItem = mediaItems[indexPath.row]

            // Set user image if URL is available
            if let imageURLString = mediaItem.uRL, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
                cell.statusImgView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
                cell.statusImgView.backgroundColor = .clear // Reset background color
            } else {
                cell.statusImgView.image = nil
                cell.statusImgView.backgroundColor = .clear
            }

            // Set text story
            
            if let backgroundColorString = mediaItem.textBackground, !backgroundColorString.isEmpty {
                cell.statusImgView.backgroundColor = UIColor(hex: backgroundColorString)
                cell.lblStatusText.text = mediaItem.text ?? ""
                cell.lblStatusText.isHidden = false
            } else {
                cell.statusImgView.backgroundColor = .clear
                cell.lblStatusText.isHidden = true
            }

            // Set time
            if let statusDate = mediaItem.date, let statusTime = mediaItem.time {
                let elapsedTimeString = Converter.timeAgo(Date: statusDate, Time: statusTime) ?? ""
                cell.lblTime.text = elapsedTimeString
            } else {
                cell.lblTime.text = ""
            }

            // Configure separator visibility
            let isLastCell = indexPath.row == mediaItems.count - 1
            cell.configureSeparator(isLastCell: isLastCell)
        }

        cell.callBack = {
            tableView.reloadData()
        }
        return cell
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stories = myStorys, let selectedData = stories.first else { return }
        
        let statusStoryVC = StoryViewController.GetInstance()
        statusStoryVC.modalPresentationStyle = .overCurrentContext

        // Pass the stories and the tag
        statusStoryVC.contactStoriesData = selectedData
        statusStoryVC.selectedTag = indexPath.row
        statusStoryVC.fromScreen = "MyStory"
        // Wrap the compactMap result in an array to match the expected type
        if let mediaURLs = selectedData.media?.compactMap({ $0.uRL }) {
            statusStoryVC.imageCollection = [mediaURLs]
        } else {
            statusStoryVC.imageCollection = [[]] // or nil, based on your needs
        }
        
       
        self.present(statusStoryVC, animated: true)
    }

}
