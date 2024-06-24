//
//  WeatherViewController.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import UIKit
import Toast_Swift

class WeatherViewController: WhiteColorNoneNavigation {
    
    @IBOutlet weak var btnLongPress: UIButton!
    @IBOutlet weak var selectCityBtn: UIButton!
    @IBOutlet weak var lblWeatherApp: UILabel!
    @IBOutlet weak var collectioninnerView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempratureView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationAddressLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dayTitleLbl: UILabel!
    
    
    class func getInstance()-> WeatherViewController {
        return WeatherViewController.viewController(storyboard: Constants.Storyboard.Main)
    }
    
    var arrWeatherData: WeatherListModel?
    var hourModel = [HourModel]()
    var hourModels = [Singleton.sharedInstance.arrCityWeatherData?.forecast?.forecastday?[0].hour]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        cellNib()
        getWeatherData()
        setFont()
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))
        longGesture.minimumPressDuration = 3
        btnLongPress.addGestureRecognizer(longGesture)
        // Do any additional setup after loading the view.
        
        print(getCurrentDate(format: "HH"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    //MARK:- Cell nib
    func cellNib(){
        self.tableView.register(WeatherListCell.nib, forCellReuseIdentifier: WeatherListCell.identifier)
        self.collectionView.register(WeatherDayListCollectionCell.nib, forCellWithReuseIdentifier: WeatherDayListCollectionCell.identifier)
    }
    
    func setFont(){
        locationAddressLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
        dateLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
        
        temperatureLbl.font = Nunitonsans.nuniton_bold.font(size: 70)
        statusLbl.font = Nunitonsans.nuniton_regular.font(size: 14)
        
        dayTitleLbl.font = Nunitonsans.nuniton_bold.font(size: 17)
        lblWeatherApp.font = Nunitonsans.nuniton_extraBold.font(size: 19)
        
        tempratureView.layer.cornerRadius = 20
        weatherImageView.layer.cornerRadius = 20
        collectioninnerView.layer.cornerRadius = 7
        collectionView.layer.cornerRadius = 7
    }
    
    func bindData(){
        
        locationAddressLbl.text = "\(arrWeatherData?.locations?.name ?? "")," + " " + (arrWeatherData?.locations?.region ?? "")
        dateLbl.text = getConvertedDate(format: "d MMM yyyy", dateString: (arrWeatherData?.locations?.localtime ?? ""))
        
        //        temperatureLbl.text = "\(arrWeatherData?.current?.temp_c ?? 0)"
        statusLbl.text = arrWeatherData?.current?.condition?.text ?? ""
        
        let attrString = NSMutableAttributedString(string: "\(arrWeatherData?.current?.temp_c ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: temperatureLbl.font.pointSize)])

        attrString.append(NSMutableAttributedString(string:"°", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),.baselineOffset: NSNumber(value: 40)]))
        temperatureLbl.attributedText = attrString
        
        
        
        hourModel = [HourModel]()
        if arrWeatherData?.forecast?.forecastday?.count ?? 0 > 0 {
            let hourCount = arrWeatherData?.forecast?.forecastday?[0].hour?.suffix(from: 17).prefix(4)
            for item in hourCount ?? [] {
                hourModel.append(item)
            }
        }
        
       // dayTitleLbl.text = "Next \(arrWeatherData?.forecast?.forecastday?.count ?? 0) Days"
        if let actualCount = arrWeatherData?.forecast?.forecastday?.count {
            let displayCount = min(actualCount, 2)
            dayTitleLbl.text = "Next \(displayCount) Days"
        } else {
            dayTitleLbl.text = "Next 0 Days" // Or handle the nil case appropriately
        }

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
 
    func bindDatareset() {
        // Safely unwrap arrCityWeatherData
        guard let arrWeatherData = Singleton.sharedInstance.arrCityWeatherData else {
            // Handle the case when arrWeatherData is nil, maybe show an error message or return from the function
            return
        }
        
        // Set location and date labels
        locationAddressLbl.text = "\(arrWeatherData.locations?.name ?? ""), \(arrWeatherData.locations?.region ?? "")"
        dateLbl.text = getConvertedDate(format: "d MMM yyyy", dateString: arrWeatherData.locations?.localtime ?? "")
        
        // Set status label
        statusLbl.text = arrWeatherData.current?.condition?.text ?? ""
        
        // Set temperature label with attributed string
        let attrString = NSMutableAttributedString(
            string: "\(arrWeatherData.current?.temp_c ?? 0)",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: temperatureLbl.font.pointSize)]
        )
        attrString.append(
            NSMutableAttributedString(
                string: "°",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30), .baselineOffset: NSNumber(value: 40)]
            )
        )
        temperatureLbl.attributedText = attrString
        
        // Initialize hourModel as an empty array of HourModel
        hourModel = [HourModel]()
        
        // Check if forecast data is available
        if let forecastDay = arrWeatherData.forecast?.forecastday, forecastDay.count > 0 {
            // Get the last 4 hours of the forecast starting from the 17th hour
            if let hourCount = forecastDay[0].hour?.suffix(from: 17).prefix(4) {
                for item in hourCount {
                    hourModel.append(item)
                }
            }
        }
        
        // Set day title label
     
        if let actualCount = arrWeatherData.forecast?.forecastday?.count {
             let displayCount = min(actualCount, 2)
             dayTitleLbl.text = "Next \(displayCount) Days"
         } else {
             dayTitleLbl.text = "Next 0 Days" // Or handle the nil case appropriately
         }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func selectCityAction(_ sender: Any)
    {
        let CitysPopUPVC = CitysPopUPVC.getInstance()
        CitysPopUPVC.modalPresentationStyle = .overCurrentContext
        CitysPopUPVC.callback = {
          //  self.getWeatherData()
            self.bindDatareset()
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        present(CitysPopUPVC, animated: true)
    }
    @IBAction func longPressAction(_ sender: Any)
    {
       
    }
    @objc func long(gesture: UILongPressGestureRecognizer) {
        let userData = getUserData()
        print("UserData", userData ?? "nil")
        
        if gesture.state == .began {
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    if userData != nil {
                        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
                        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "Two_step_verificationPopUpVC") as? Two_step_verificationPopUpVC {
                            destinationVC.modalPresentationStyle = .overCurrentContext
                            if let viewController = UIViewController.currentViewc() {
                                
                                // Present the new view controller after the dismissal animation completes
                                viewController.present(destinationVC, animated: true, completion: nil)
                            }
                        }
                    } else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "WelcomeToTheWeatherAppVC") as? WelcomeToTheWeatherAppVC {
                            destinationVC.modalPresentationStyle = .overCurrentContext
                            if let viewController = UIViewController.currentViewcc() {
                                // Present the new view controller after the dismissal animation completes
                                viewController.present(destinationVC, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier, for: indexPath) as? WeatherListCell {
            
            let adjustedIndex = indexPath.row + 1
            
            if Singleton.sharedInstance.arrCityWeatherData?.forecast?.forecastday?.count ?? 0 > adjustedIndex {
                
                let data = Singleton.sharedInstance.arrCityWeatherData?.forecast?.forecastday?[adjustedIndex]
                // 2023-03-16
                cell.dateLbl.text = getCustomConvertedDate(format: "dd MMMM yyyy", toFormat: "yyyy-MM-dd", dateString: data?.date ?? "")
                cell.statusLbl.text = data?.day?.condition?.text ?? ""
                cell.temperatureLbl.text = "\(data?.day?.mintemp_c ?? 0) / \(data?.day?.maxtemp_c ?? 0)"
                cell.imageIcon.getImage(data?.day?.condition?.icon?.replacingOccurrences(of: "//", with: "https://") ?? "")
            } else {
                let data = arrWeatherData?.forecast?.forecastday?[adjustedIndex]
                // 2023-03-16
                cell.dateLbl.text = getCustomConvertedDate(format: "dd MMMM yyyy", toFormat: "yyyy-MM-dd", dateString: data?.date ?? "")
                cell.statusLbl.text = data?.day?.condition?.text ?? ""
                cell.temperatureLbl.text = "\(data?.day?.mintemp_c ?? 0) / \(data?.day?.maxtemp_c ?? 0)"
                cell.imageIcon.getImage(data?.day?.condition?.icon?.replacingOccurrences(of: "//", with: "https://") ?? "")
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(hourModel.count, 3)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDayListCollectionCell.identifier, for: indexPath) as? WeatherDayListCollectionCell {
            
//            let data = arrWeatherData?.forecast?.forecastday?[0].hour?[indexPath.item]
            let data = hourModel[indexPath.item]
            
            cell.imageIcon.getImage(data.condition?.icon?.replacingOccurrences(of: "//", with: "https://") ?? "")
            cell.temperatureLbl.text = "\(data.temp_c ?? 0)"
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    
    
}

//MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK:- API Call
extension WeatherViewController {
    // Get weather data
    func getWeatherData(){
        DataManager.shared.getWeatherDetail(view: self.view) { [weak self] (result) in
            switch result {
            case .success(let appWeatherModel):
                    print("appWeatherModel ", appWeatherModel)
                self?.arrWeatherData = appWeatherModel
                self?.bindData()
                self?.tableView.reloadData()
                self?.collectionView.reloadData()

            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
            }
        }
    }
    
    
    
    
    
}
