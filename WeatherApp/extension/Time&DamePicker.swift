//
//  Time&DamePicker.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 20/06/24.
//

import Foundation

protocol DateTimeViewModelDelegate: AnyObject {
    func didFetchCurrentDateTime(date: String, time: String)
    func didFailFetchingDateTime(with error: Error)
}

class DateTimeViewModel {
    weak var delegate: DateTimeViewModelDelegate?
    
    func fetchCurrentDateTime() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        // Date format for date: "11-11-1111"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        // Date format for time: "11:11:11"
        dateFormatter.dateFormat = "hh:mm:ss"
        let formattedTime = dateFormatter.string(from: currentDate)
        
        delegate?.didFetchCurrentDateTime(date: formattedDate, time: formattedTime)
    }
}
