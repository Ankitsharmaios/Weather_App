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
    
    //MARK: User Register
    func UserRegister(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<RegisterModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.RegisterCheck)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: RegisterModel.self) { (mappableArray, apiError) in
            
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

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: verifyOTPModel.self) { (mappableArray, apiError) in
            
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
    
    //MARK: EditProfile
    func EditProfile(params: [String : Any], isLoader:Bool,view:UIView, _ completion: @escaping(Result<EditProfileModel, APIError>) -> Void) {

        // Create URL
        let url = getURL(.EditProfile)

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: EditProfileModel.self) { (mappableArray, apiError) in
            
            guard let data = mappableArray as? EditProfileModel else {
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

        NetworkManager.shared.postResponse(url, parameter: params, header: getHttpHeaders(), mappingType: AddTwoStepVerificationcodeModel.self) { (mappableArray, apiError) in
            
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
    
}
