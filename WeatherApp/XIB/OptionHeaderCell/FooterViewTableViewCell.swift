//
//  FooterViewTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/06/24.
//

import UIKit

class FooterViewTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblYourPersonal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
