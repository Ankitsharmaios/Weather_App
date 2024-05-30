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
    
    static func timeAgo(from timeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Adjust the format based on your time string

        guard let time = dateFormatter.date(from: timeString) else {
            return "Invalid time"
        }

        let currentDate = Date()

        // Combine the given time with the current date to get the full date-time
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = currentComponents.year
        combinedComponents.month = currentComponents.month
        combinedComponents.day = currentComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        combinedComponents.second = timeComponents.second
        
        guard let combinedDate = calendar.date(from: combinedComponents) else {
            return "Invalid date"
        }
        
        // If the combined date is in the future, use the date from the previous day
        if combinedDate > currentDate {
            combinedComponents.day = currentComponents.day! - 1
        }
        
        guard let finalDate = calendar.date(from: combinedComponents) else {
            return "Invalid date"
        }
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: finalDate, to: currentDate)

        if let hours = components.hour, hours >= 24 {
            return "More than a day ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        } else if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
        } else {
            return "Just now"
        }
    }

    
    
}
