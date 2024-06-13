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
     
    func getWeatherDetail(view: UIView, _ completion: @escaping(Result<WeatherListModel, APIError>) -> Void) {
            
            // Create URL
            let baseURL = "http://api.weatherapi.com/v1/forecast.json"
            let apiKey = AppKeys.WeatherKey.rawValue
            let cityName = UserLoginData.CityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "New Delhi"
            let days = 3
            
            let urlString = "\(baseURL)?key=\(apiKey)&q=\(cityName)&days=\(days)"
            
            NetworkManager.shared.getResponse(urlString, mappingType: WeatherListModel.self, view: view) { result in
                switch result {
                case .success(let weatherData):
                    completion(.success(weatherData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    func getCityWeatherDetail(city:String,view:UIView, _ completion: @escaping(Result<WeatherListModel, APIError>) -> Void) {
        
        // Create URL
        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=\(city)&days=3"
        print(url)
        //        let url = "http://api.weatherapi.com/v1/forecast.json?key=\(AppKeys.WeatherKey.rawValue)&q=Ahmedabad&dt=\(getCurrentDate(format: "yyyy-MM-dd"))"
        
        NetworkManager.shared.postResponse(url, mappingType: WeatherListModel.self,view:view) { (mappableArray, apiError) in
            guard let data = mappableArray as? WeatherListModel else {
                //   APPLICATION_DELEGATE.toastMessage(message: Validation.somethingWentWrong)
             //  completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            completion(.success(data))
        }
    }
    
    //MARK: User Register
    func UserRegister(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<RegisterModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.RegisterCheck)

        NetworkManager.shared.postResponse(url,parameter: params, mappingType: RegisterModel.self, view: view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? RegisterModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    //MARK: VerifyOTP
    func VerifyOTP(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<verifyOTPModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.VerifyOTP)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: verifyOTPModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? verifyOTPModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    
    //MARK: CheckTwoFactor
    func CheckTwoFactor(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<CheckTwoFactorModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.CheckTwoFactor)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: CheckTwoFactorModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? CheckTwoFactorModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    //MARK: AddTwoStepVerificationcode
    func AddTwoStepVerificationcode(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<AddTwoStepVerificationcodeModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.AddTwoStepVerificationcode)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: AddTwoStepVerificationcodeModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? AddTwoStepVerificationcodeModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    
    //MARK: Logout
    func Logout(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<LogOutModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.Logout)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: LogOutModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? LogOutModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    //MARK: StoryList
    func StoryList(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<StoryListModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.StoryList)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: StoryListModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? StoryListModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    //MARK: addStory
    func addStory(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<addStoryModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.addStory)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: addStoryModel.self,view:view) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? addStoryModel else {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }
            
            print("status \(data.status ?? false)")
            print("message \(data.statusMessage ?? "")")
            
            if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                completion(.failure(apiError ?? .errorMessage("Something went wrong")))
                return
            }else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                completion(.success(data))
            } else{
                completion(.success(data))
            }
        }
    }
    
    
 
    // MARK: AppConfig
    func AppConfig(isLoader: Bool, view: UIView, _ completion: @escaping (Result<AppConfigModel, APIError>) -> Void) {
        
        // Create URL
        let url = getURL(.AppConfig)
        
        NetworkManager.shared.getResponse(url, mappingType: AppConfigModel.self, view: view) { result in
            switch result {
            case .success(let data):
                print("status \(data.status ?? false)")
                print("message \(data.statusMessage ?? "")")
                
                if !(data.status ?? false) && data.statusMessage == "Token Expired" {
                    completion(.failure(.errorMessage("Token Expired")))
                } else if !(data.status ?? false) && data.statusMessage == "login failed !" {
                    completion(.failure(.errorMessage("Login failed!")))
                } else {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    
    
}
