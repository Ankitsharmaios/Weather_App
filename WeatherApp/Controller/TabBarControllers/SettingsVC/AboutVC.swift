//
//  AboutVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 19/06/24.
//

import UIKit
import SwiftUI

class AboutVC: UIViewController {

    @IBOutlet weak var toptableView: UITableView!
    @IBOutlet weak var tableviewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var aboutTableView: UITableView!
    @IBOutlet weak var btnmoreOption: UIButton!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var btnBack: UIButton!
   
    var callback: ((String) -> Void )?
    var isTopTableHide = false
    var OptionNames:[String] = ["Delete all"]
    var abouts:[String] = ["Available","Busy","At school","At the movies","At work","Battery about to die","Cant't talk,WhatApp only","In a meeting","At the gym","Sleeping","Urgent calls only"]
   
    var passAbout = ""
    
    let sectionTitles: [String] = ["Currently set to", "Select About"]
    class func getInstance()-> AboutVC {
        return AboutVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNib()
       
        toptableView.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.toptableView.isHidden = true
    }
    
    func setNib() {
            toptableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil), forCellReuseIdentifier: "optionHeaderTblvCell")
            aboutTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil), forCellReuseIdentifier: "optionHeaderTblvCell")
        aboutTableView.register(UINib(nibName: "AboutTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutTableViewCell")
        
            toptableView.dataSource = self
            toptableView.delegate = self
            aboutTableView.dataSource = self
            aboutTableView.delegate = self
            aboutTableView.separatorStyle = .none
            toptableView.separatorStyle = .none
            aboutTableView.showsVerticalScrollIndicator = false

            toptableView.addShadowToTableView(view: toptableView, value: 2)
            aboutTableView.estimatedRowHeight = 40
            aboutTableView.rowHeight = UITableView.automaticDimension
        }
    

    
    func updateTableViewHeight() {
            let contentHeight = aboutTableView.contentSize.height
            tableviewHeightLayout.constant = contentHeight
            view.layoutIfNeeded()
        }
    
    @IBAction func moreOptionAction(_ sender: Any)
    {
        isTopTableHide.toggle()
        toptableView.isHidden = !isTopTableHide
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
        
    }
    
}
// MARK: TableView Methods
extension AboutVC:UITableViewDataSource & UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == aboutTableView{
            return 2
        }else if tableView == toptableView{
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == aboutTableView{
            if section == 0
            {
                return 1
            }else if section == 1
            {
                return abouts.count
            }
           
        }else if tableView == toptableView{
            return OptionNames.count
        }
      return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == aboutTableView{
            if indexPath.section == 0 {
                if let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as? AboutTableViewCell{
                    cell.lblabout.text = passAbout 
                    return cell
                }
            }else if indexPath.section == 1{
                if let cell = aboutTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
                    cell.nameLbl.text = abouts[indexPath.row]
                     
                    return cell
                }
            }
            return UITableViewCell()
        }else if tableView == toptableView{
            if let cell = toptableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
                cell.nameLbl.text = OptionNames[indexPath.row]
               
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == aboutTableView
        {
            return UITableView.automaticDimension
        }else if tableView == toptableView
        {
            return UITableView.automaticDimension
        }
       return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == aboutTableView {
            if indexPath.section == 0 {
                self.toptableView.isHidden = true
                DispatchQueue.main.async {
                    let viewController = NamePopUpVC.getInstance()
                    viewController.modalPresentationStyle = .overCurrentContext
                    viewController.isfrom = "About"
                    
                    // Pass the text from lblabout if the cell is of type AboutTableViewCell
                    if let cell = tableView.cellForRow(at: indexPath) as? AboutTableViewCell {
                        viewController.selectedData = cell.lblabout.text ?? ""
                    }
                    
                    viewController.callback = { [weak self] about in
                                        
                                            self?.callback?(about)
                                    }
                    
                    
                    self.present(viewController, animated: true)
                }
            }
        }
    

        
        
        
        if tableView == toptableView {
            self.toptableView.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if tableView == aboutTableView {
                updateTableViewHeight()
            }
        }
    
    // MARK: - Section Header Methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == aboutTableView {
            let headerView = UIView()
            
            
            let label = UILabel()
            label.text = sectionTitles[section]
            label.textColor = appThemeColor.Gray_Colure
            label.font = Helvetica.helvetica_bold.font(size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
                label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
                label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
            ])
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == aboutTableView {
            return 30
        }
        return 0
    }
   
}
