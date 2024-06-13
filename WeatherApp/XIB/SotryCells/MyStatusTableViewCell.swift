//
//  MyStatusTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 13/06/24.
//

import UIKit
import SDWebImage
class MyStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var tableviewHeightlayout: NSLayoutConstraint!
    @IBOutlet weak var hideShowTableView: UITableView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var lblStatusText: UILabel!
    @IBOutlet weak var viewLbl: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var callBack: (() -> Void )?
    var toggle = false
    var optionArray = ["Forward","Share...","Share to facebook","Delete"]
    
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
        hideShowTableView.isHidden = true
        tableviewHeightlayout.constant = CGFloat(CGFloat((optionArray.count)) * (22))
        hideShowTableView.addShadowToTableView(view: hideShowTableView, value: 2)
        hideShowTableView.dataSource = self
        hideShowTableView.delegate = self
        
        hideShowTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil),forCellReuseIdentifier: "optionHeaderTblvCell")
        hideShowTableView.separatorStyle = .none
        
        
        
        
        viewLbl.font = Helvetica.helvetica_semibold.font(size: 15)
        viewLbl.textColor = appThemeColor.CommonBlack
        
        lblTime.font = Helvetica.helvetica_regular.font(size: 12)
        lblTime.textColor = appThemeColor.text_LightColure
        
        statusImgView.layer.cornerRadius = statusImgView.frame.size.width / 2
        statusImgView.clipsToBounds = true
        
        lblStatusText.isHidden = true
    }
    

    @IBAction func moreOptionAction(_ sender: Any)
    {
        toggle.toggle()
        if toggle == true
        {
            hideShowTableView.isHidden = false
            hideShowTableView.reloadData()
        }else{
            hideShowTableView.isHidden = true
            hideShowTableView.reloadData()
        }
    }
}
extension MyStatusTableViewCell:UITableViewDataSource & UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = hideShowTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
            cell.nameLbl.text = optionArray[indexPath.row]
           
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
