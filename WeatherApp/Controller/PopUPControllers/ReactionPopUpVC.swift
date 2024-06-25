//
//  ReactionPopUpVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 25/06/24.
//

import UIKit

class ReactionPopUpVC: UIViewController {
    
 
    @IBOutlet weak var btnSad: UIButton!
    @IBOutlet weak var btnWow: UIButton!
    @IBOutlet weak var btnHaha: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var reacionView: UIView!
    @IBOutlet weak var btnLove: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    class func getInstance()-> ReactionPopUpVC {
        return ReactionPopUpVC.viewController(storyboard: Constants.Storyboard.PopUp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reacionView.layer.cornerRadius = 22
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAction(_ sender: Any)
    {
    }
    @IBAction func sadAction(_ sender: Any) 
    {
    }
    @IBAction func wowAction(_ sender: Any) 
    {
    }
    @IBAction func hahaAction(_ sender: Any) 
    {
    }
    @IBAction func loveAction(_ sender: Any) 
    {
    }
    @IBAction func likeAction(_ sender: Any) 
    {
    }
    @IBAction func backAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
    }
}
