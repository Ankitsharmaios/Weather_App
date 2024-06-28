//
//  ContactMediaColletionCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/06/24.
//

import UIKit

class ContactMediaColletionCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mediadurationView: UIView!
    @IBOutlet weak var lblmediaDuration: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 5
        mainView.clipsToBounds = true
        lblmediaDuration.font = Helvetica.helvetica_regular.font(size: 10)
        lblmediaDuration.textColor = appThemeColor.white
        
        mediadurationView.isHidden = true
    }

}
