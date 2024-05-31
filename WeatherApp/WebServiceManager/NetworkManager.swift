//
//  NetworkManager.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SVProgressHUD
import Photos
import Toast_Swift

enum HUDFlag: Int {
    case show = 1
    case hide = 0
}

class NetworkManager: Session {
    
    static let shared = NetworkManager()
    
    //----------------------------------------------------------------
    // MARK: Get Request Method
    //----------------------------------------------------------------
    
    func getResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        self.objectRequest(url, method: .get, parameter: parameter, encoding: encoding, header: header, mappingType: mappingType, showHUD: showHUD) { (mappableResponse) in
            
            switch mappableResponse.result {
                
            case .success(let data):
                completion(data, nil)
                break
                
            case .failure(let error):
                completion(nil, .errorMessage(error.localizedDescription))
                break
            }
        }
    }
    
    //--------------------------------------------------
    
    func getArray<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, mappingType: [T].Type, completion: @escaping ([Mappable]?, APIError?) -> Void) {
        
        self.arrayRequest(url, method: .get, parameter: parameter, encoding: encoding, header: header, mappingType: mappingType) { (mappableArray) in
            
            switch mappableArray.result {
            
            case .success(let data):
                completion(data, nil)
                break
                
            case .failure(let error):
                completion(nil, .errorMessage(error.localizedDescription))
                break
            }
        }
    }
    
    
    // ----------------------------------------------------------------
    // MARK: Post Request Method
    // ----------------------------------------------------------------
    
//    func postResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
//        
//        self.objectRequest(url, method: .post, parameter: parameter, encoding: encoding, header: header, mappingType: mappingType, showHUD: showHUD) { (mappableResponse) in
//            
//            switch mappableResponse.result {
//                
//            case .success(let data):
//                completion(data, nil)
//                break
//                
//            case .failure(let error):
//                completion(nil, .errorMessage(error.localizedDescription))
//                break
//            }
//        }
//    }
    func postResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, mappingType: T.Type, view: UIView, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        // Check network status
        if Singleton.sharedInstance.networkStatus.lowercased() == "offline" {
            var toastStyle = ToastStyle()
            toastStyle.backgroundColor = appThemeColor.text_Weather
            view.makeToast("Please Check Internet Connection", duration: 5.0, position: .bottom, style: toastStyle)
            completion(nil, .errorMessage("No internet connection"))
            return
        }
        
        self.objectRequest(url, method: .post, parameter: parameter, encoding: encoding, header: header, mappingType: mappingType, showHUD: showHUD) { (mappableResponse) in
            
            switch mappableResponse.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, .errorMessage(error.localizedDescription))
            }
        }
    }


    
    // ----------------------------------------------------------------
    // MARK: Object Request Method
    // ----------------------------------------------------------------
    
    func objectRequest<T: BaseMappable>(_ url: String, method: Alamofire.HTTPMethod, parameter: Parameters? = nil, encoding: ParameterEncoding, header: HTTPHeaders? = nil, mappingType: T.Type, showHUD: HUDFlag = .show, completionHandler: @escaping (DataResponse<T, AFError>) -> Void) -> Void {
        
//        if !APPLICATION_DELEGATE.checkInternetConnection(){
//           APPLICATION_DELEGATE.toastMessage(message: Validation.internetConnection)
//            return
//        }
        
        if showHUD == .show {
            SVProgressHUD.show()
        }
        
        self.request(url, method: method, parameters: parameter, encoding: encoding, headers: header).responseObject { (response: DataResponse<T, AFError>) in
            
            SVProgressHUD.dismiss()
            
            //Logs print
            APILogs().printAPILogs(url: url, parmas: parameter ?? [:], method: method.rawValue, header: header ?? HTTPHeaders(), response: response)
            
            completionHandler(response as DataResponse<T, AFError>)
        }
    }
    
    //MARK: - Form data
    //--------------------------------------------------
    
    func getFormDataResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        self.objectFormDataRequest(url, method: .get, parameter: parameter, encoding: encoding, header: header, mappingType: mappingType, showHUD: showHUD) { (mappableResponse) in
            
            switch mappableResponse.result {
                
            case .success(let data):
                completion(data, nil)
                break
                
            case .failure(let error):
                completion(nil, .errorMessage(error.localizedDescription))
                break
            }
        }
    }
    
    func objectFormDataRequest<T: BaseMappable>(_ url: String, method: Alamofire.HTTPMethod, parameter: Parameters? = nil, encoding: ParameterEncoding, header: HTTPHeaders? = nil, mappingType: T.Type, showHUD: HUDFlag = .show, completionHandler: @escaping (DataResponse<T, AFError>) -> Void) -> Void {
        
//        if !APPLICATION_DELEGATE.checkInternetConnection(){
//            APPLICATION_DELEGATE.toastMessage(message: Validation.internetConnection)
//            return
//        }
//        
        if showHUD == .show {
            SVProgressHUD.show()
        }
        
        self.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append("App".data(using: String.Encoding.utf8)!, withName: AppSetting.AppName)
            
        }, to: URL.init(string: url)!, usingThreshold: UInt64.init(), method: method, headers: header).responseObject { (response: DataResponse<T, AFError>) in
            SVProgressHUD.dismiss()
            
            //Logs print
            APILogs().printAPILogs(url: url, parmas: parameter ?? [:], method: method.rawValue, header: header ?? HTTPHeaders(), response: response)
            
            completionHandler(response as DataResponse<T, AFError>)
        }
    }
    
    //--------------------------------------------------
    
    func arrayRequest<T: BaseMappable>(_ url: String, method: Alamofire.HTTPMethod, parameter: Parameters? = nil, encoding: ParameterEncoding, header: HTTPHeaders? = nil, mappingType: [T].Type, completionHandler: @escaping (DataResponse<[T], AFError>) -> Void) -> Void {
        
        SVProgressHUD.show()
        
        self.request(url, method: method, parameters: parameter, encoding: encoding, headers: header).responseArray { (response: DataResponse<[T], AFError>) in
            
            SVProgressHUD.dismiss()
            
            completionHandler(response as DataResponse<[T], AFError>)
        }
    }
}
