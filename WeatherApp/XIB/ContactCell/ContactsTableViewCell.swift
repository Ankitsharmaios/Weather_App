//
//  ContactsTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 18/06/24.
//

import UIKit
import SDWebImage
class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    var userList : UserResultModel? {
        didSet{
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setUpCell()
    {
        userimageView.layer.cornerRadius = userimageView.frame.size.width / 2
        userimageView.clipsToBounds = true
        
       
        lblName.textColor = appThemeColor.CommonBlack
        
        lblStatus.font = Helvetica.helvetica_regular.font(size: 11)
        lblStatus.textColor = appThemeColor.text_LightColure
    }
    
    func setData() {
        guard let detail = userList else {
            return
        }
        
        lblName.text = detail.name
        
        // Ensure the 'about' text is not nil
        if let aboutText = detail.about {
            lblStatus.text = aboutText
        } else {
            lblStatus.text = ""
        }
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()

        // Set user image
        if let imageURLStrings = detail.image, !imageURLStrings.isEmpty,
           let imageURL = URL(string: imageURLStrings) {
            userimageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Place_Holder"), options: .highPriority, completed: nil)
        } else {
            userimageView.image = UIImage(named: "Place_Holder")
        }

    }

    
}
