//
//  RightViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {

    @IBOutlet weak var reacionView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    var isLongPressed = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.rounded(radius: 12)
        messageContainerView.backgroundColor = UIColor(hexString: "E1F7CB")
        reacionView.layer.cornerRadius = 15
        reacionView.isHidden = true
        greenView.isHidden = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(message: Message) {
        textMessageLabel.text = message.text
        greenView.isHidden = !isLongPressed
        reacionView.isHidden = !isLongPressed
    }
}
