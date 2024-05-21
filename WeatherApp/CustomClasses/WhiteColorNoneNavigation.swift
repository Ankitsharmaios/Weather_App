//
//  WhiteColorNoneNavigation.swift
//  UniviaFarmer
//
//  Created by Nikunj on 1/23/23.
//

import UIKit

class WhiteColorNoneNavigation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBar(navigateTitle: "")
    }
    
    //MARK: - Set Navigation bar
    func setNavigationBar(navigateTitle: String){
        self.navigationController?.isNavigationBarHidden = false

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: Nunitonsans.nuniton_bold.font(size: 15
                                                                                                                                         )]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backToView))
        let titlelbl = UILabel()
        titlelbl.text = navigateTitle
        titlelbl.font = Nunitonsans.nuniton_bold.font(size: 17)
        self.navigationItem.leftBarButtonItems = [backButton, UIBarButtonItem(customView: titlelbl)]
        
        let title = UILabel()
        title.text = self.navigationItem.title
        title.font = Nunitonsans.nuniton_bold.font(size: 17)

        let spacer = UIView()
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow

        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal

        navigationItem.titleView = stack
    }
    
    @objc func backToView(){
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
