//
//  APILogs.swift
//  UniviaFarmer
//
//  Created by Nikunj on 1/24/23.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class APILogs {
    func printAPILogs<T: BaseMappable>(url: String, parmas: [String : Any], method: String, header: HTTPHeaders, response: DataResponse<T, AFError>){
        let JSONString = response.value?.toJSONString(prettyPrint: false)
        print("URL: ", url)
        print("Parma: ", parmas)
        print("Method: ", method)
        print("Header: ", header)
        print("Response: ", JSONString ?? "")
    }
}
