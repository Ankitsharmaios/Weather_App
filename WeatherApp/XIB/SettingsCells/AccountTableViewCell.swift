//
//  AccountTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var mainView: UIView!
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
        lblTitle.font = Helvetica.helvetica_regular.font(size: 18)
        lblTitle.textColor = appThemeColor.CommonBlack
    }
    
}
