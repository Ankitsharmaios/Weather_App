//
//  LeftViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit


class LeftViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var reacionView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    var isLongPressed = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.rounded(radius: 12)
        messageContainerView.backgroundColor = .white
        reacionView.layer.cornerRadius = 15
        reacionView.isHidden = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        greenView.isHidden = true
    }
    
    func configureCell(message: Message) {
            textMessageLabel.text = message.text
            lblTime.text = formatTime(message.time)
            greenView.isHidden = !isLongPressed
            reacionView.isHidden = !isLongPressed
        }
    private func formatTime(_ time: String) -> String {
           let timeComponents = time.split(separator: ":")
           if timeComponents.count >= 2 {
               return "\(timeComponents[0]):\(timeComponents[1])"
           }
           return time
       }
}



extension UIView {
    func rounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
