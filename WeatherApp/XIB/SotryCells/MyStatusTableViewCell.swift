//
//  MyStatusTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 13/06/24.
//

import UIKit
import SDWebImage
class MyStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var lblStatusText: UILabel!
    @IBOutlet weak var viewLbl: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var callBack: (() -> Void )?
    var customAlertView: CustomAlertView?
    var isOpen = false
    var optionArray = ["Forward","Share...","Share to facebook","Delete"]
    var buttonAction: ((Int) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
       
    }

    func configureSeparator(isLastCell: Bool) {
            separatorView.isHidden = isLastCell
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell()
    {
        
        viewLbl.font = Helvetica.helvetica_semibold.font(size: 15)
        viewLbl.textColor = appThemeColor.CommonBlack
        
        lblTime.font = Helvetica.helvetica_regular.font(size: 12)
        lblTime.textColor = appThemeColor.text_LightColure
        
        statusImgView.layer.cornerRadius = statusImgView.frame.size.width / 2
        statusImgView.clipsToBounds = true
        
        lblStatusText.isHidden = true
    }
    

    @IBAction func OptionMoreAction(_ sender: UIButton)
    {
        if isOpen {
                hideCustomActionSheet()
            } else {
                isOpen = true
                showCustomActionSheet()
                let buttonTag = sender.tag
                print("Button tag: \(buttonTag)")
                buttonAction?(buttonTag)
            }
    }
    
    private func showCustomActionSheet() {
        guard let viewController = self.getViewController(), let storyID = Singleton.sharedInstance.storyId else { return }
        
        // Close previously open action sheet if any
    //    NotificationCenter.default.post(name: Notification.Name("CloseActionSheet"), object: nil)
        
        customAlertView = CustomAlertView(options: optionArray)
        customAlertView?.optionSelected = { [weak self] option in
            print("\(option) selected")
            if option == "Delete" {
                self?.hideCustomActionSheet()  // Hide the action sheet first
                let deletePopUpVC = DeletePopUpVC.getInstance()
                deletePopUpVC.id = storyID
                deletePopUpVC.callback = {
                    self?.callBack?()
                }
                deletePopUpVC.modalPresentationStyle = .overCurrentContext
                viewController.present(deletePopUpVC, animated: true, completion: nil)
            }
        }
        customAlertView?.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(customAlertView!)
        if let buttonSuperview = btnMoreOption.superview {
            let buttonFrameInView = buttonSuperview.convert(btnMoreOption.frame, to: viewController.view)
            NSLayoutConstraint.activate([
                customAlertView!.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: 0),
                customAlertView!.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: buttonFrameInView.maxY + 10),
                customAlertView!.widthAnchor.constraint(equalToConstant: 200)
            ])
        }
        viewController.view.layoutIfNeeded()
        isOpen = true
    }

    private func hideCustomActionSheet() {
        customAlertView?.removeFromSuperview()
        isOpen = false
    }
}
