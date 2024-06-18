//
//  StoryTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 29/05/24.
//

import UIKit
import SDWebImage
import WhatsappStatusRingBar
class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var imgHeightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var imgWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var nameTopLayout: NSLayoutConstraint!
    @IBOutlet weak var lbltextStatusShow: UILabel!
    @IBOutlet weak var imgInnerView: WhatsappStatusRingBar!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var userimageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var callback : (() -> Void )?
    var storyData : StoryResultModel? {
        didSet{
            setData()
      
            setupProgressView(progress: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpUI()
    {
       
        lblTime.isHidden = true
        
        lbltextStatusShow.isEnabled = true
        
        lblName.font = Helvetica.helvetica_semibold.font(size: 16)
        lblName.textColor = appThemeColor.CommonBlack
        
        lblTime.font = Helvetica.helvetica_regular.font(size: 15)
        lblTime.textColor = appThemeColor.text_LightColure
        
        imgInnerView.layer.cornerRadius = imgInnerView.frame.size.width / 2
        imgInnerView.clipsToBounds = true

        userimageView.layer.cornerRadius = userimageView.frame.size.width / 2
        userimageView.clipsToBounds = true
    
        userimageView.layer.borderWidth = 1.5
        userimageView.layer.borderColor = appThemeColor.white.cgColor
        
    }
    
    func setupProgressView(progress:Int) {
        
        if let media = storyData?.media {
            let totalURLs = media.compactMap { $0.uRL }.count
            self.imgInnerView.total = totalURLs
        } else {
            self.imgInnerView.total = 0
        }
        self.imgInnerView.unseenProgressColor = appThemeColor.text_Weather
        self.imgInnerView.seenProgressColor = appThemeColor.btnLightGrey_BackGround
        self.imgInnerView.setProgress(progress: CGFloat(progress))
        self.imgInnerView.lineWidth = 2.5
    }

    func setData() {
          guard let detail = storyData else {
              return
          }
          
          // Set user image
          if let imageURLStrings = detail.media?.compactMap({ $0.uRL }),
             let firstImageURLString = imageURLStrings.last, !firstImageURLString.isEmpty,
             let imageURL = URL(string: firstImageURLString) {
              userimageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
              userimageView.backgroundColor = .clear // Reset background color
              lbltextStatusShow.isHidden = true // Hide text status
          } else {
              userimageView.image = UIImage(named: "placeholder")
              // Set background color if image URL is empty
              if let media = detail.media?.last, let backgroundColorString = media.textBackground, let backgroundColor = UIColor(hex: backgroundColorString) {
                  userimageView.backgroundColor = backgroundColor
                  lbltextStatusShow.isHidden = false
                  lbltextStatusShow.text = media.text?.truncated(wordsLimit: 2) ?? ""
              } else {
                  userimageView.backgroundColor = .clear // Default color if no background color is specified
                  lbltextStatusShow.isHidden = true // Hide text status
              }
          }
          
//          // Get the latest status date and time
//          if let media = detail.media, let latestMedia = media.last,
//             let statusDate = latestMedia.date,
//             let statusTime = latestMedia.time {
//              
//              // Calculate time difference and set it to the label
//              let elapsedTimeString = Converter.timeAgo(Date: statusDate, Time: statusTime)
//              lblTime.text = elapsedTimeString
//          } else {
//              lblTime.text = ""
//          }
          
          // Set user name
          lblName.text = detail.userName
      }
    
  
}
