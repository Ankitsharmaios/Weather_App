//
//  TimeConverter.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 28/05/24.
//

import Foundation
struct Converter{
    static func convertApiTimeToAMPM(apiTime: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        if let date = dateFormatter.date(from: apiTime) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
