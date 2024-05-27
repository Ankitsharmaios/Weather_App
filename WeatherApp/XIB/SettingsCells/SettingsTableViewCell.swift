//
//  SettingsTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblsubTitle: UILabel!

    @IBOutlet var userImageView: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCell()
        // Configure the view for the selected state
    }
    
    func setUpCell(){
        lblTitle.font = Helvetica.helvetica_regular.font(size: 15)
        lblTitle.textColor = appThemeColor.CommonBlack
        
        lblsubTitle.font = Helvetica.helvetica_regular.font(size: 13)
        lblsubTitle.textColor = appThemeColor.text_LightColure
        
    }
    
}
