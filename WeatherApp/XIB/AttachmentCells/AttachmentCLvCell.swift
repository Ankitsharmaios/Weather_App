//
//  AttachmentCLvCell.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import UIKit

class AttachmentCLvCell: UICollectionViewCell {

    @IBOutlet weak var namesLbl: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        namesLbl.textColor = appThemeColor.text_LightColure
        // Initialization code
    }

}
