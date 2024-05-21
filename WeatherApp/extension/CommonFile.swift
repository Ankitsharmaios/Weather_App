//
//  CommonFile.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import Foundation
import UIKit
import AVKit




func getCurrentDate(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: Date())
}

func getConvertedDate(format: String, dateString: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = format

    if let date = dateFormatterGet.date(from: dateString) {
        return dateFormatterPrint.string(from: date)
    } else {
       print("There was an error decoding the string")
        return dateFormatterGet.string(from: Date())
    }
}


func getCustomConvertedDate(format: String, toFormat: String, dateString: String) -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = toFormat
    
    print("Sender DateToFormate \(toFormat)")
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = format

    print("Sender DateFormate \(toFormat)")
    
    if let date = dateFormatterGet.date(from: dateString) {
        print("Sender Date \(dateString)")
        return dateFormatterPrint.string(from: date)
    } else {
       print("There was an error decoding the string")
        return dateFormatterGet.string(from: Date())
    }
}

func getTimeAgo(dateString: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    let now = dateFormatter.date(from:dateString) ?? Date()
    
    return now
}



func getDurationDateTime(dateString: String) -> Date {
   /* let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "MM-dd-yyyy HH:mm:ss"

    if let date = dateFormatterGet.date(from: dateString) {
        return date
    } else {
       print("There was an error decoding the string")
        return Date()
    }*/
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
    let date = dateFormatter.date(from:dateString) ?? Date()
    
    return date
}

func timeAgo(date: Date) -> String {

    let secondsAgo = Int(Date().timeIntervalSince(date))

    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    let month = 4 * week

    let quotient: Int
    let unit: String
    if secondsAgo < minute {
        quotient = secondsAgo
        unit = "second"
    } else if secondsAgo < hour {
        quotient = secondsAgo / minute
        unit = "min"
    } else if secondsAgo < day {
        quotient = secondsAgo / hour
        unit = "hour"
    } else if secondsAgo < week {
        quotient = secondsAgo / day
        unit = "day"
    } else if secondsAgo < month {
        quotient = secondsAgo / week
        unit = "week"
    } else {
        quotient = secondsAgo / month
        unit = "month"
    }
    return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
}

func getTimeSince(date: Date, isShort: Bool = false) -> String {
    var formattedString = String()
    let now = Date()
    let secondsAgo = Int(now.timeIntervalSince(date))
    
    let twoSeconds = 2
    let minute = 60
    let twoMinutes = minute * 2
    let hour = 60 * minute
    let twoHours = hour * 2
    let day = 24 * hour
    let twoDays = day * 2
    let week = 7 * day
    let twoWeeks = week * 2
    let month = 4 * week
    let twoMonths = month * 2
    let year = 12 * month
    let twoYears = year * 2
    
    let secondString = isShort ? "s ago" : " second ago"
    let secondsString = isShort ? "s ago" : " seconds ago"
    let minuteString = isShort ? "m ago" : " minute ago"
    let minutesString = isShort ? "m ago" : " minutes ago"
    let hourString = isShort ? "h ago" : " hour ago"
    let hoursString = isShort ? "h ago" : " hours ago"
    let dayString = isShort ? "d ago" : " day ago"
    let daysString = isShort ? "d ago" : " days ago"
    let weekString = isShort ? "w ago" : " week ago"
    let weeksString = isShort ? "w ago" : " weeks ago"
    let monthString = isShort ? "mo ago" : " month ago"
    let monthsString = isShort ? "mo ago" : " months ago"
    let yearString = isShort ? "y ago" : " year ago"
    let yearsString = isShort ? "y ago" : " years ago"
    
    if secondsAgo < twoSeconds {
        formattedString = "\(secondsAgo)\(secondString)"
    } else if secondsAgo < minute {
        formattedString = "\(secondsAgo)\(secondsString)"
    } else if secondsAgo < twoMinutes {
        formattedString = "\(secondsAgo / minute)\(minuteString)"
    } else if secondsAgo < hour {
        formattedString = "\(secondsAgo / minute)\(minutesString)"
    } else if secondsAgo < twoHours {
        formattedString = "\(secondsAgo / hour)\(hourString)"
    } else if secondsAgo < day {
        formattedString = "\(secondsAgo / hour)\(hoursString)"
    } else if secondsAgo < twoDays {
        formattedString = "\(secondsAgo / day)\(dayString)"
    } else if secondsAgo < week {
        formattedString = "\(secondsAgo / day)\(daysString)"
    } else if secondsAgo < twoWeeks {
        formattedString = "\(secondsAgo / week)\(weekString)"
    } else if secondsAgo < month {
        formattedString = "\(secondsAgo / week)\(weeksString)"
    } else if secondsAgo < twoMonths {
        formattedString = "\(secondsAgo / month)\(monthString)"
    } else if secondsAgo < year {
        formattedString = "\(secondsAgo / month)\(monthsString)"
    } else if secondsAgo < twoYears {
        formattedString = "\(secondsAgo / year)\(yearString)"
    } else {
        formattedString = "\(secondsAgo / year)\(yearsString)"
    }
    return formattedString
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
//    func toInt() -> Double? {
//        return NumberFormatter().number(from: self)?.intValue
//    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

func getimageExtensions(imageUrl: String) -> String {
    let imageExtensions = ["png", "jpg", "gif", "jpeg", "JPG", "PNG", "JPEG", "GIF", "HEIC"]

    let url = URL(fileURLWithPath: imageUrl)
    let pathExtention = url.pathExtension
    if imageExtensions.contains(pathExtention){
        print("Image URL: \(String(describing: url))")
        // Do something with it
        return "Image"
    }
    else{
        print("Movie URL: \(String(describing: url))")
        return "Video"
    }
}

func videoPlayer(url: String){
    let videoURL = URL(string: url)
    let player = AVPlayer(url: videoURL!)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    APPLICATION_DELEGATE.window?.rootViewController?.present(playerViewController, animated: true) {
        playerViewController.player!.play()
    }
}

extension String {
    var numberValue:NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    
    }
}
extension URL {
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        if let parameters = url.queryItems {
            return parameters.first(where: { $0.name == queryParam })?.value
        } else if let paramPairs = url.fragment?.components(separatedBy: "?").last?.components(separatedBy: "&") {
            for pair in paramPairs where pair.contains(queryParam) {
                return pair.components(separatedBy: "=").last
            }
            return nil
        } else {
            return nil
        }
    }
}
extension UIApplication {
//
//    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//
//        if let nav2 = base as? UINavigationController {
//            return getTopViewController(base: nav2.visibleViewController)
//
//        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//            return getTopViewController(base: selected)
//
//        } else if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
//        return base
//    }
}
