//
//  LeftImgVideoTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/06/24.
//
import UIKit

class LeftImgVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgeinnerView: UIView!

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var shareImgeandVideoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        imgeinnerView.backgroundColor = .white

        imgeinnerView.layer.cornerRadius = 10
        shareImgeandVideoView.layer.cornerRadius = 10
        shareImgeandVideoView.clipsToBounds = true
    }

    func configure(with mediaURL: String, time: String) {
           // Example: Assuming you use SDWebImage for image loading
           shareImgeandVideoView.sd_setImage(with: URL(string: mediaURL), placeholderImage: UIImage(named: "Place_Holder"))
           lblTime.text = formatTime(time)
       }
    
    private func formatTime(_ time: String) -> String {
            let timeComponents = time.split(separator: ":")
            if timeComponents.count >= 2 {
                return "\(timeComponents[0]):\(timeComponents[1])"
            }
            return time
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
