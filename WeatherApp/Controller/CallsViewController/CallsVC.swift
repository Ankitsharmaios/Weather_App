//
//  CallsVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 17/06/24.
//

import UIKit

class CallsVC: UIViewController {

    @IBOutlet weak var lblToStartcalling: UILabel!
    @IBOutlet weak var lblCalls: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
    }
    

    func setUpUI()
    {
        lblCalls.font = Nunitonsans.nuniton_regular.font(size: 22)
        lblCalls.textColor = appThemeColor.CommonBlack
        
        lblToStartcalling.font = Helvetica.helvetica_regular.font(size: 15)
        lblToStartcalling.textColor = appThemeColor.text_LightColure
        
        
        
    }

}
