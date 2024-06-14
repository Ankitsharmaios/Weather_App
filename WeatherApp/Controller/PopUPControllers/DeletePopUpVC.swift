//
//  DeletePopUpVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 14/06/24.
//

import UIKit

class DeletePopUpVC: UIViewController {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCancel: UIStackView!
    @IBOutlet weak var lblDelete: UILabel!
    @IBOutlet weak var mainView: UIView!
   
    var id:Int?
    var callback: (() -> Void)?
    class func getInstance()-> DeletePopUpVC {
        return DeletePopUpVC.viewController(storyboard: Constants.Storyboard.PopUp)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        lblDelete.font = Helvetica.helvetica_regular.font(size: 14)
        lblDelete.textColor = appThemeColor.Gray_Colure
        
        mainView.layer.cornerRadius = 25
    }
    
    
    @IBAction func deleteAction(_ sender: Any) 
    {
        DeleteStory(StoryId: id ?? 0)
    }
    
    @IBAction func cancelAction(_ sender: Any) 
    {
        self.dismiss(animated:true)
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
}
extension DeletePopUpVC {
    
    // MARK: Call Api
    func DeleteStory(StoryId: Int) {
        let param = ["RegisterId": getString(key: userDefaultsKeys.RegisterId.rawValue),
                     "StoryId": StoryId,
                    ] as [String : Any]
        
        DataManager.shared.DeleteStory(params: param, isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let DeleteStory):
                print("DeleteStory ", DeleteStory)
              
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true) {
                            self?.callback?()
                        }
                    }
                
               
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
            }
        }
    }
}
