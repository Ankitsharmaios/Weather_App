//
//  WeatherViewController.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import UIKit

class WeatherViewController: WhiteColorNoneNavigation {
    
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
    
    var arrWeatherData: WeatherListModel?
    var hourModel = [HourModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        cellNib()
        getWeatherData()
        setFont()
        // Do any additional setup after loading the view.
        
        print(getCurrentDate(format: "HH"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   setNavigationBar(navigateTitle: ScreenlableTitle.Weather_WeatherlableTitle)
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
        
        dayTitleLbl.text = "Next \(arrWeatherData?.forecast?.forecastday?.count ?? 0) Days"
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
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

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeatherData?.forecast?.forecastday?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier, for: indexPath) as? WeatherListCell {
            
            let data = arrWeatherData?.forecast?.forecastday?[indexPath.row]
            // 2023-03-16
            cell.dateLbl.text = getCustomConvertedDate(format: "dd MMMM yyyy", toFormat: "yyyy-MM-dd", dateString: data?.date ?? "")
            cell.statusLbl.text = data?.day?.condition?.text ?? ""
            cell.temperatureLbl.text = "\(data?.day?.maxtemp_c ?? 0) / \(data?.day?.mintemp_c ?? 0)"
            cell.imageIcon.getImage(data?.day?.condition?.icon?.replacingOccurrences(of: "//", with: "https://") ?? "")
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
        return hourModel.count
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
        return CGSize(width: 70, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK:- API Call
extension WeatherViewController {
    // Get weather data
    func getWeatherData(){
        DataManager.shared.getWeatherDetail() { [weak self] (result) in
            switch result {
            case .success(let appWeatherModel):
                //                print("appBannerListModel ", appBannerListModel)
                self?.arrWeatherData = appWeatherModel
                self?.bindData()
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
               // APPLICATION_DELEGATE.genarateUserToken { statuscode in
                 //   if statuscode {
                        // Call API
                     //   self?.getWeatherData()
               //     }
              //  }
            }
        }
    }
}
