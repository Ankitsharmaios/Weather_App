//SVProgressHUD.dismiss()
//
//  WebServices.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import ObjectMapper
import Alamofire
//import SVProgressHUD

extension DataManager {
     
    func getWeatherDetail( _ completion: @escaping(Result<WeatherListModel, APIError>) -> Void) {
        
        // Create URL
        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=\(UserLoginData.CityName)&days=3"
        print(url)
        //        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=Ahmedabad&dt=\(getCurrentDate(format: "yyyy-MM-dd"))"
        
        NetworkManager.shared.postResponse(url, mappingType: WeatherListModel.self) { (mappableArray, apiError) in
            guard let data = mappableArray as? WeatherListModel else {
                //   APPLICATION_DELEGATE.toastMessage(message: Validation.somethingWentWrong)
             //  completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            completion(.success(data))
        }
    }
    func getCityWeatherDetail(city:String, _ completion: @escaping(Result<WeatherListModel, APIError>) -> Void) {
        
        // Create URL
        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=\(city)&days=3"
        print(url)
        //        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=Ahmedabad&dt=\(getCurrentDate(format: "yyyy-MM-dd"))"
        
        NetworkManager.shared.postResponse(url, mappingType: WeatherListModel.self) { (mappableArray, apiError) in
            guard let data = mappableArray as? WeatherListModel else {
                //   APPLICATION_DELEGATE.toastMessage(message: Validation.somethingWentWrong)
             //  completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            completion(.success(data))
        }
    }
}
