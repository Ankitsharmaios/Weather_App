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
    
    static func convertApiDateTime(apiDate: String, apiTime: String) -> String? {
            let dateTimeString = "\(apiDate) \(apiTime)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss" // Adjust this format based on your API response format

            // Parse the combined date and time string
            guard let date = dateFormatter.date(from: dateTimeString) else { return nil }

            let calendar = Calendar.current

            // Check if the date is today or yesterday
            if calendar.isDateInToday(date) {
                return "Today, " + Converter.formatDateToAMPM(date: date)
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday, " + Converter.formatDateToAMPM(date: date)
            } else {
                dateFormatter.dateFormat = "MMM d, h:mm a"
                return dateFormatter.string(from: date)
            }
        }

        private static func formatDateToAMPM(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        }
    
    static func timeAgo(Date dateString: String, Time timeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss" // Adjust the format based on your date and time string

        let dateTimeString = "\(dateString) \(timeString)"
        
        guard let date = dateFormatter.date(from: dateTimeString) else {
            return "Invalid date or time"
        }

        let currentDate = Date()
        let calendar = Calendar.current

        // Calculate the time difference
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: date, to: currentDate)


        // Determine the appropriate time ago string
        if let days = components.day, days >= 1 {
            if days == 1 {
                return "Yesterday"
            } else {
                return "\(days) day\(days > 1 ? "s" : "") ago"
            }
        }
        
        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        }
        
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        }
        
        if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
        } else {
            return "Just now"
        }
        
      
        
        
    }

//    static func timeAgo(Date dateString: String, Time timeString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss" // Adjust the format based on your date and time string
//
//        let dateTimeString = "\(dateString) \(timeString)"
//        
//        guard let date = dateFormatter.date(from: dateTimeString) else {
//            return "Invalid date or time"
//        }
//
//        let currentDate = Date()
//        let calendar = Calendar.current
//
//        // Calculate the time difference
//        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: date, to: currentDate)
//
//        // Determine the appropriate time ago string
//        if let days = components.day, days >= 1 {
//            if days == 1 {
//                return "Yesterday"
//            } else {
//                return "\(days) day\(days > 1 ? "s" : "") ago"
//            }
//        }
//        
//        if let hours = components.hour, hours > 0 {
//            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
//        }
//        
//        if let minutes = components.minute, minutes > 0 {
//            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
//        }
//        
//        if let seconds = components.second, seconds > 0 {
//            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
//        } else {
//            return "Just now"
//        }
//    }

//    static func timeAgo(from timeString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss" // Adjust the format based on your time string
//
//        guard let time = dateFormatter.date(from: timeString) else {
//            return "Invalid time"
//        }
//
//        let currentDate = Date()
//
//        // Combine the given time with the current date to get the full date-time
//        let calendar = Calendar.current
//        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
//        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
//        
//        var combinedComponents = DateComponents()
//        combinedComponents.year = currentComponents.year
//        combinedComponents.month = currentComponents.month
//        combinedComponents.day = currentComponents.day
//        combinedComponents.hour = timeComponents.hour
//        combinedComponents.minute = timeComponents.minute
//        combinedComponents.second = timeComponents.second
//        
//        guard let combinedDate = calendar.date(from: combinedComponents) else {
//            return "Invalid date"
//        }
//        
//        // If the combined date is in the future, use the date from the previous day
//        if combinedDate > currentDate {
//            combinedComponents.day = currentComponents.day! - 1
//        }
//        
//        guard let finalDate = calendar.date(from: combinedComponents) else {
//            return "Invalid date"
//        }
//        
//        let components = calendar.dateComponents([.hour, .minute, .second], from: finalDate, to: currentDate)
//
//        if let hours = components.hour, hours >= 24 {
//            return "More than a day ago"
//        } else if let hours = components.hour, hours > 0 {
//            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
//        } else if let minutes = components.minute, minutes > 0 {
//            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
//        } else if let seconds = components.second, seconds > 0 {
//            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
//        } else {
//            return "Just now"
//        }
//    }

    
    
}
