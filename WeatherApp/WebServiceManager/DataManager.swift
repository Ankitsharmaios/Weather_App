//
//  DataManager.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import Alamofire

class DataManager: NSObject {
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //------------------------------------------------------------------------------
    
    static let shared   = DataManager()
    let baseUrl         = WebServiceURL.URLDomain
    
    // Create http headers
    func getHttpHeaders() -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        httpHeader["Accept"] = "application/json"
        httpHeader["Content-Type"] = "application/json"
        httpHeader["APIToken"] = UserToken.userToken
        return httpHeader
    }
    
    // Create http Form data headers
    func getHttpFormDataHeaders() -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        httpHeader["Accept"] = "application/json"
        httpHeader["Content-Type"] = "multipart/form-data"
        httpHeader["APIToken"] = UserToken.userToken
        return httpHeader
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //------------------------------------------------------------------------------
    
    // Get API url with endpoints
    func getURL(_ endpoint: WSEndPoints) -> String {
        return baseUrl + endpoint.rawValue
    }
}

// MARK:-
// MARK:- WebserviceURL
//------------------------------------------------------------------------------

struct WebServiceURL {
//    static let URLDomain = "http://uboapis.testingbeta.in/api/" // Live
//    static let URLDomain = "https://api.univia.tk/api/" // Staging --- Last used - till 10/01/2024
    static let URLDomain = "https://wadmin.testingbeta.online/api/" // After 10/01/2024 changes
  //  static let globasDomain = "https://api.univia.cc" //Note : Where above domain change please this also
}

//------------------------------------------------------------------------------
// MARK:-
// MARK:- WebserviceEndPoints
//------------------------------------------------------------------------------

enum WSEndPoints: String {
    case RegisterCheck = "RegisterCheck"
    case VerifyOTP = "VerifyOTP"
    case EditProfile = "EditProfile"
    case AddTwoStepVerificationcode = "AddTwoStepVerificationcode"
    case CheckTwoFactor = "CheckTwoFactor"
    case Logout = "Logout"
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- enum - Result
//------------------------------------------------------------------------------

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- enum - APIError
//------------------------------------------------------------------------------

enum APIError: Error {
    case errorMessage(String)
    case requestFailed(String)
    case jsonConversionFailure(String)
    case invalidData(String)
    case responseUnsuccessful(String)
    case jsonParsingFailure(String)
    
    var localizedDescription: String {
        
        switch self {
            
        case.errorMessage(let msg):
            return msg
            
        case .requestFailed(let msg):
            return msg
            
        case .jsonConversionFailure(let msg):
            return msg
            
        case .invalidData(let msg):
            return msg
            
        case .responseUnsuccessful(let msg):
            return msg
            
        case .jsonParsingFailure(let msg):
            return msg
        }
    }
}
