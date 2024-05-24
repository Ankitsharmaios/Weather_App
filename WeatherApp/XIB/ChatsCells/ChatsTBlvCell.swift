//
//  ChatsTBlvCell.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import UIKit

class ChatsTBlvCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var ViewStatusImage: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI(){
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        usernameLbl.font = Helvetica.helvetica_bold.font(size: 16)
        messageLbl.textColor = appThemeColor.text_LightColure
        timeLbl.textColor = appThemeColor.text_LightColure
        timeLbl.font = Helvetica.helvetica_regular.font(size: 14)
        messageLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
    }
    
}
