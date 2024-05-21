//
//  WeatherListCell.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import UIKit

class WeatherListCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        dateLbl.font = Nunitonsans.nuniton_regular.font(size: 15)
//        statusLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
//        temperatureLbl.font = Nunitonsans.nuniton_regular.font(size: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
