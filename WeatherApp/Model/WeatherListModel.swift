//
//  WeatherListModel.swift
//  UniviaFarmer
//
//  Created by Nikunj on 2/12/23.
//

import Foundation
import ObjectMapper

struct WeatherListModel: Mappable {
    var locations: WeatherLocationModel?
    var current: WeatherCurrentModel?
    var forecast: ForecastModel?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        locations <- map["location"]
        current <- map["current"]
        forecast <- map["forecast"]
    }
}

// Location model
struct WeatherLocationModel: Mappable {
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var tz_id: String?
    var localtime_epoch: Int?
    var localtime: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        name <- map["name"]
        region <- map["region"]
        country <- map["country"]
        lat <- map["lat"]
        lon <- map["lon"]
        tz_id <- map["tz_id"]
        localtime_epoch <- map["localtime_epoch"]
        localtime <- map["localtime"]
    }
}

// Current model
struct WeatherCurrentModel: Mappable {
    var last_updated_epoch: Int?
    var last_updated: String?
    var temp_c: Double?
    var is_day: Int?
    var condition: ConditionModel?
    var wind_kph: Double?
    var wind_dir: String?
    var precip_mm: Double?
    var precip_in: Double?
    var humidity: Double?
    var cloud: Double?
    var feelslike_c: Double?
    var vis_km: Double?
    var uv: Double?
    var gust_kph: Double?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        last_updated_epoch <- map["last_updated_epoch"]
        last_updated <- map["last_updated"]
        temp_c <- map["temp_c"]
        is_day <- map["is_day"]
        condition <- map["condition"]
        wind_kph <- map["wind_kph"]
        wind_dir <- map["wind_dir"]
        precip_mm <- map["precip_mm"]
        precip_in <- map["precip_in"]
        humidity <- map["humidity"]
        cloud <- map["cloud"]
        feelslike_c <- map["feelslike_c"]
        vis_km <- map["vis_km"]
        uv <- map["uv"]
        gust_kph <- map["gust_kph"]
    }
}

struct ConditionModel: Mappable {
    var icon: String?
    var text: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        icon <- map["icon"]
        text <- map["text"]
    }
}

//Forecast model
struct ForecastModel: Mappable {
    var forecastday: [ForecastDayModel]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        forecastday <- map["forecastday"]
    }
}

//Forecast day model
struct ForecastDayModel: Mappable {
    var date: String?
    var date_epoch: Int?
    var day: DayModel?
    var astro: AstroModel?
    var hour: [HourModel]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        date <- map["date"]
        date_epoch <- map["date_epoch"]
        day <- map["day"]
        astro <- map["astro"]
        hour <- map["hour"]
    }
}

// Day
struct DayModel: Mappable {
    var maxtemp_c: Double?
    var mintemp_c: Double?
    var avgtemp_c: Double?
    var maxwind_kph: Double?
    var totalprecip_mm: Double?
    var totalsnow_cm: Double?
    var avgvis_km: Double?
    var avghumidity: Double?
    var daily_will_it_rain: Double?
    var daily_chance_of_rain: Double?
    var condition: ConditionModel?
    var uv: Double?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        maxtemp_c <- map["maxtemp_c"]
        mintemp_c <- map["mintemp_c"]
        avgtemp_c <- map["avgtemp_c"]
        maxwind_kph <- map["maxwind_kph"]
        totalprecip_mm <- map["totalprecip_mm"]
        totalsnow_cm <- map["totalsnow_cm"]
        avgvis_km <- map["avgvis_km"]
        avghumidity <- map["avghumidity"]
        daily_will_it_rain <- map["daily_will_it_rain"]
        daily_chance_of_rain <- map["daily_chance_of_rain"]
        condition <- map["condition"]
        uv <- map["uv"]
    }
}

//Astro model
struct AstroModel: Mappable {
    var sunrise: String?
    var sunset: String?
    var is_moon_up: Double?
    var is_sun_up: Double?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        is_moon_up <- map["is_moon_up"]
        is_sun_up <- map["is_sun_up"]
    }
}

//Hour model
struct HourModel: Mappable {
    var time: String?
    var temp_c: Double?
    var condition: ConditionModel?
    var wind_kph: Double?
    var wind_dir: String?
    var precip_mm: Double?
    var humidity: Double?
    var cloud: Double?
    var feelslike_c: Double?
    var windchill_c: Double?
    var heatindex_c: Double?
    var dewpoint_c: Double?
    var will_it_rain: Double?
    var chance_of_rain: Double?
    var vis_km: Double?
    var gust_mph: Double?
    var uv: Double?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        time <- map["time"]
        temp_c <- map["temp_c"]
        condition <- map["condition"]
        wind_kph <- map["wind_kph"]
        wind_dir <- map["wind_dir"]
        precip_mm <- map["precip_mm"]
        humidity <- map["humidity"]
        cloud <- map["cloud"]
        feelslike_c <- map["feelslike_c"]
        windchill_c <- map["windchill_c"]
        heatindex_c <- map["heatindex_c"]
        dewpoint_c <- map["dewpoint_c"]
        will_it_rain <- map["will_it_rain"]
        chance_of_rain <- map["chance_of_rain"]
        vis_km <- map["vis_km"]
        gust_mph <- map["gust_mph"]
        uv <- map["uv"]
    }
}
