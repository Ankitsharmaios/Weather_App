//
//  AboutTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 19/06/24.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblabout: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        lblabout.font = Nunitonsans.nuniton_semiBold.font(size: 15)
        lblabout.textColor = appThemeColor.CommonBlack
    }
    
}
