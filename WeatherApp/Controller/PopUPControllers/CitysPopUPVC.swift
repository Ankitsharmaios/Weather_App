//
//  CitysPopUPVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 21/05/24.
//

import UIKit
import Toast_Swift

class CitysPopUPVC: UIViewController {
    
    
    @IBOutlet weak var lblSelecteLocation: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnChangeLocation: UIButton!
    @IBOutlet weak var mainView: UIView!
    var arrWeatherData: WeatherListModel?
    var hourModel = [HourModel]()
    let citysImages: [String] = ["ahmedabad","bangalore","chennai","hyderabad","kolkata","mumbai","delhi","pune"]
    let citysName: [String] = ["Ahmedabad","Bangalore","Chennai","Hyderabad","Kolkata","Mumbai","New Delhi","Pune"]
    let selectCityImages: [String] = ["Select_ahmedabad","Select_bangalore","Select_chennai","Select_hyderabad","Select_kolkata","Select_mumbai","Select_delhi","Select_pune"]
    let selectedLabelColor = appThemeColor.selectedCityColure
    var selectedIndexPath: IndexPath?
    var selectedCity = ""
    var callback: (() -> Void)?
   
    class func getInstance()-> CitysPopUPVC {
        return CitysPopUPVC.viewController(storyboard: Constants.Storyboard.PopUp)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))  //Tap function will call when user tap on button
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))  //Long function will call when user long press on button.
        longGesture.minimumPressDuration = 2
        tapGesture.numberOfTapsRequired = 1
        btnChangeLocation.addGestureRecognizer(tapGesture)
        btnChangeLocation.addGestureRecognizer(longGesture)
    }
    
    func registerNib()
    {
        collectionView.register(UINib(nibName: "CitysCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CitysCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupUI()
    {
        lblSelecteLocation.font = Helvetica.helvetica_medium.font(size: 17)
        lblSelecteLocation.textColor = appThemeColor.CommonBlack
      
        btnChangeLocation.setTitleColor(appThemeColor.white, for: .normal)
        
        btnChangeLocation.layer.cornerRadius = btnChangeLocation.frame.size.height / 2
        btnChangeLocation.clipsToBounds = true
        
        mainView.layer.cornerRadius = 5
        
    }
    
    
    @objc func tap() {
        if self.selectedCity == ""
        {
            self.view.makeToast("Please Select City")
        }else
        {
            getCityWeatherData(cityname: self.selectedCity)
        }
        }

    @objc func long() {
        print("Long press")
    }
    
    @IBAction func dissmissAction(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeLocationAction(_ sender: Any)
    {
       
       
    }
    
}
extension CitysPopUPVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citysImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitysCollectionViewCell", for: indexPath) as! CitysCollectionViewCell
            
            let imageName = citysImages[indexPath.item]
            let selectedImageName = selectCityImages[indexPath.item]
            let cityName = citysName[indexPath.item]
            
            let image = (indexPath == selectedIndexPath) ? UIImage(named: selectedImageName) : UIImage(named: imageName)
            let textColor = (indexPath == selectedIndexPath) ? selectedLabelColor : appThemeColor.citynameColure
            
            cell.configure(with: image!, text: cityName, textColor: textColor)
            
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height / 3-4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the previously selected cell
        if let previousIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CitysCollectionViewCell
            previousCell?.cityLbl.textColor = appThemeColor.citynameColure
            // Access the image name directly from the array without optional binding
            let previousImageName = citysImages[previousIndexPath.item]
            previousCell?.imageView.image = UIImage(named: previousImageName)
            print("Deselect the previously selected cell")
        }
        
        // Select the new cell
        selectedIndexPath = indexPath
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CitysCollectionViewCell
        selectedCell?.cityLbl.textColor = selectedLabelColor
        // Directly access the image name from the array without optional binding
        let selectedImageName = selectCityImages[indexPath.item]
        selectedCell?.imageView.image = UIImage(named: selectedImageName)
        print("Select the new cell",selectedCell?.cityLbl.text! ?? "")
        self.selectedCity = selectedCell?.cityLbl.text! ?? ""
    }

    
    
}
extension CitysPopUPVC
{
    func getCityWeatherData(cityname:String){
        DataManager.shared.getCityWeatherDetail(city: cityname) { [weak self] (result) in
            switch result {
            case .success(let getCityWeatherDetail):
                    print("getCityWeatherDetail ", getCityWeatherDetail)
                self?.arrWeatherData = getCityWeatherDetail
                Singleton.sharedInstance.arrCityWeatherData = getCityWeatherDetail
                
                DispatchQueue.main.async {
                    self?.callback?()
                    self?.dismiss(animated: true)
                }
                
                
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
            }
        }
    }
}
