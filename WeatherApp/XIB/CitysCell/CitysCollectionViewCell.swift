//
//  CitysCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 21/05/24.
//

import UIKit

class CitysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        // Initialization code

    }

    func setupCell()
    {
        cityLbl.textColor = appThemeColor.citynameColure
    }
    
    func configure(with image: UIImage, text: String, textColor: UIColor) {
            imageView.image = image
            cityLbl.text = text
            cityLbl.textColor = textColor
        }
    
}
