//
//  WeatherDayListCollectionCell.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import UIKit

class WeatherDayListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      //  temperatureLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
    }

}
