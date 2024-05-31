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

    @IBOutlet weak var imgInnerView: WhatsappStatusRingBar!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var userimageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    var storyData : StoryResultModel? {
        didSet{
            setData()
            setupProgressView()
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
        lblName.font = Helvetica.helvetica_semibold.font(size: 16)
        lblName.textColor = appThemeColor.CommonBlack
        
        lblTime.font = Helvetica.helvetica_regular.font(size: 15)
        lblTime.textColor = appThemeColor.text_LightColure
        
        imgInnerView.layer.cornerRadius = imgInnerView.frame.size.width / 2
        imgInnerView.clipsToBounds = true
//        imgInnerView.layer.borderWidth = 2.5
//        imgInnerView.layer.borderColor = appThemeColor.text_Weather.cgColor
        userimageView.layer.cornerRadius = userimageView.frame.size.width / 2
        userimageView.clipsToBounds = true
    
        userimageView.layer.borderWidth = 1.5
        userimageView.layer.borderColor = appThemeColor.white.cgColor
        
    }
    
    func setupProgressView() {
        
        if let media = storyData?.media {
            let totalURLs = media.compactMap { $0.uRL }.count
            self.imgInnerView.total = totalURLs
        } else {
            self.imgInnerView.total = 0
        }
        self.imgInnerView.unseenProgressColor = appThemeColor.text_Weather
        self.imgInnerView.seenProgressColor = appThemeColor.btnLightGrey_BackGround
        //self.imgInnerView.setProgress(progress: 1)
        self.imgInnerView.lineWidth = 2.5
    }
    
    func setData()
    {
        guard let detail = storyData else {
            return
        }
        
      
        if let imageURLStrings = detail.media?.compactMap({ $0.uRL }), let firstImageURLString = imageURLStrings.first, let imageURL = URL(string: firstImageURLString) {
            userimageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userimageView.image = UIImage(named: "placeholder")
        }


        if let timeString = detail.media?[0].time {
                   lblTime.text = formatTimeString(timeString)
               } else {
                   lblTime.text = ""
               }

        lblName.text = detail.userName
    }
    
    func formatTimeString(_ timeString: String) -> String {
            let components = timeString.split(separator: ":")
            if components.count >= 2 {
                // Join the first two components (hours and minutes)
                return "\(components[0]):\(components[1])"
            }
            return timeString // Return original string if it's not in the expected format
        }
}
