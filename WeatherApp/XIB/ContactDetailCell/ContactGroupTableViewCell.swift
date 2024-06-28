//
//  ContactGroupTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/06/24.
//

import UIKit

class ContactGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCreateGroupwith: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblCreateGroupwith.font = Helvetica.helvetica_regular.font(size: 16)
        lblCreateGroupwith.textColor = appThemeColor.CommonBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
