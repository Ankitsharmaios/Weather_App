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
            return "Just now"
        } else {
            return "Just now"
        }
        
      
        
        
    }
 
    
}
