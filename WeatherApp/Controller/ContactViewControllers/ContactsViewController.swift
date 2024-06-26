//
//  ContactsViewController.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 18/06/24.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var topStackViewWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var toptableHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var searchBackBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var SearchViewHideShow: UIView!
    @IBOutlet weak var newGroupHideShowView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var btnNewContact: UIButton!
    @IBOutlet weak var btnNewGroup: UIButton!
    @IBOutlet weak var lblNewContact: UILabel!
    @IBOutlet weak var lblnewGroup: UILabel!
    @IBOutlet weak var lblContactsonWhatsapp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMoreOptions: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblContactCountShow: UILabel!
    @IBOutlet weak var lblSelectContactTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var stackViewHideShow: UIStackView!
    @IBOutlet weak var stackviewHeightlayout: NSLayoutConstraint!
    var isTopTableHide = false
    var UserListData:UserListModel?
    var showTabbar: (() -> Void )?
    var isfrom = ""
    var headerViewHeightConstraint: NSLayoutConstraint?
    var OptionNames:[String] = ["Invite a friend","Contacts","Refresh","Help"]
    
    class func getInstance()-> ContactsViewController {
        return ContactsViewController.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.isTopTableHide = false
        self.topTableView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("dismiss"), object: nil)

        UserList()
        setUpUI()
        setUINib()
        
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        if isfrom == "Calls"
        {
            SearchViewHideShow.isHidden = false
            setSearchView()
            btnMoreOptions.isHidden = true
            topStackViewWidthLayout.constant = 35
        }else
        {
            SearchViewHideShow.isHidden = true
        }
        if isfrom == "Communities"
        {
            btnMoreOptions.isHidden = true
            topStackViewWidthLayout.constant = 35
        }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.dismiss(animated: true){
            self.showTabbar?()
        }
        
    }
    func setSearchView() {
        SearchViewHideShow.isHidden = false
        let cornerRadius: CGFloat = 22.0 // Adjust the corner radius as needed
        SearchViewHideShow.layer.cornerRadius = cornerRadius
        SearchViewHideShow.clipsToBounds = true
        searchTextField.becomeFirstResponder()
    }

    
    func setUpUI()
    {
        lblSelectContactTitle.font = Nunitonsans.nuniton_regular.font(size: 15)
        lblSelectContactTitle.textColor = appThemeColor.CommonBlack
        
        lblContactCountShow.font = Helvetica.helvetica_regular.font(size: 10)
        lblContactCountShow.textColor = appThemeColor.text_LightColure
        
        lblnewGroup.font = Helvetica.helvetica_regular.font(size: 15)
        lblnewGroup.textColor = appThemeColor.CommonBlack
        
        lblNewContact.font = Helvetica.helvetica_regular.font(size: 15)
        lblNewContact.textColor = appThemeColor.CommonBlack
        
        lblContactsonWhatsapp.font = Helvetica.helvetica_bold.font(size: 13)
        lblContactsonWhatsapp.textColor = appThemeColor.Gray_Colure
        
    }
    func updateHeaderViewHeight(newHeight: CGFloat) {
        // Ensure the height constraint is set before updating it
        guard let headerViewHeightConstraint = headerViewHeightConstraint else {
            return
        }
        headerViewHeightConstraint.constant = newHeight
        headerView.frame.size.height = newHeight
        tableView.tableHeaderView = headerView
    }

    func setUINib()
    {
        topTableView.isHidden = true
        tableView.register(UINib(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
       
        topTableView.register(UINib(nibName: "optionHeaderTblvCell", bundle: nil), forCellReuseIdentifier: "optionHeaderTblvCell")
        topTableView.dataSource = self
        topTableView.delegate = self
        topTableView.separatorStyle = .none
        topTableView.showsVerticalScrollIndicator = false
        topTableView.isScrollEnabled = true
        topTableView.layer.cornerRadius = 8
        topTableView.layer.masksToBounds = false
        topTableView.addShadowToTableView(view: topTableView, value: 2)
        toptableHeightLayout.constant = CGFloat(CGFloat((OptionNames.count)) * (40))
        // Ensure the headerView has a height constraint
            if let heightConstraint = headerView.findConstraint(attribute: .height) {
                headerViewHeightConstraint = heightConstraint
            } else {
                let heightConstraint = NSLayoutConstraint(item: headerView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerView.bounds.height)
                headerView.addConstraint(heightConstraint)
                headerViewHeightConstraint = heightConstraint
            }
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        

    }

    @IBAction func searchBackAction(_ sender: Any) 
    {
        SearchViewHideShow.isHidden = true
        searchTextField.resignFirstResponder()
    }
    @IBAction func newContactAction(_ sender: Any)
    {
        
    }
    @IBAction func searchAction(_ sender: Any) 
    {
        setSearchView()
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
        {
            self.showTabbar?()
        }
    }
    
    @IBAction func newGroupAction(_ sender: Any) 
    {
        
    }
    @IBAction func moreOptionsAction(_ sender: Any) 
    {
        isTopTableHide.toggle()
        if isTopTableHide == true{
            self.topTableView.isHidden = false
        }else{
            self.topTableView.isHidden = true
        }
    }
}
extension ContactsViewController:UITableViewDataSource & UITableViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView{
            return 1
        }else if tableView == topTableView{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == self.tableView{
            if UserListData?.result?.count ?? 0 > 0 {
                return UserListData?.result?.count ?? 0
            }else{
                return 0
            }
        }else if tableView == topTableView{
            return OptionNames.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        cell.userList = UserListData?.result?[indexPath.row]
        return cell
        
    } else if tableView == topTableView{
            if let cell = topTableView.dequeueReusableCell(withIdentifier: "optionHeaderTblvCell", for: indexPath) as? optionHeaderTblvCell{
                cell.nameLbl.text = OptionNames[indexPath.row]
               
                return cell
            }
        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            return UITableView.automaticDimension
        }else if tableView == topTableView{
            return 43
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            
            if isfrom == "Communities" || isfrom == "Calls"
            {
                
            }else{
                guard let userData = UserListData?.result?[indexPath.row] else { return }
                
                
                
                
                let customID = generateCustomID(registerId: getString(key: userDefaultsKeys.RegisterId.rawValue), userId: "\(String(describing: userData.id!))")
                
                let InnerChatVC = InnerChatVC.getInstance()
                InnerChatVC.modalPresentationStyle = .fullScreen
                InnerChatVC.contactUserData = userData
                InnerChatVC.customID = customID
                InnerChatVC.isfrom = "SelectContect"
                InnerChatVC.showTabbar = {
                    self.showTabBar(animated: true)
                }
                
                self.hideTabBar(animated: true)
                
                self.present(InnerChatVC, animated: true)
            }
            
        }
        
        
    }
           
    func generateCustomID(registerId: String?, userId: String?) -> String {
        let safeRegisterId = registerId ?? ""
        let safeUserId = userId ?? ""

        let customID = "\(safeRegisterId)_\(safeUserId)"
        let reverseCustomID = "\(safeUserId)_\(safeRegisterId)"
        
        // Check if either customID or reverseCustomID exists in firebaseIdsArray
        if Singleton.sharedInstance.firebaseIdsArray.contains(customID) {
            return customID
        } else if Singleton.sharedInstance.firebaseIdsArray.contains(reverseCustomID) {
            return reverseCustomID
        } else {
            return reverseCustomID
        }
    }

}
extension ContactsViewController
{
    //MARK: Call Api
    func UserList(){
        let param = ["RegisterId":getString(key: userDefaultsKeys.RegisterId.rawValue),
        ]
        
        DataManager.shared.UserList(params: param,isLoader: true, view: view) { [weak self] (result) in
            switch result {
            case .success(let UserList):
                print("UserList ", UserList)
                self?.UserListData = UserList
                
                if self?.isfrom == "Communities"
               {
                    self?.lblSelectContactTitle.text = "New Communities"
                    self?.lblContactCountShow.text = "Add member"
                }else{
                    self?.lblSelectContactTitle.text = "Select Contact"
                    self?.lblContactCountShow.text = "\(UserList.result?.count ?? 0) contacts"
                }
                
                self?.tableView.reloadData()
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
    
    func hideTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            _ = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height
            }
        }
    }
    
    func showTabBar(animated: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            let tabBarHeight = tabBar.frame.size.height
            let duration = animated ? 0.3 : 0.0
            
            UIView.animate(withDuration: duration) {
                tabBar.frame.origin.y = self.view.frame.size.height - tabBarHeight
            }
        }
    }
    
}
extension UIView {
    func findConstraint(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return constraints.first { $0.firstAttribute == attribute && $0.firstItem as? UIView == self }
    }
}
