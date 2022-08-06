//
//  API.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//


import Foundation

// connecting to API of website OpenWeather
struct API {
    // place for own API key
    static let key = "58e501226b02e20c012ed922a5b37e1e"
    
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    // creating request string:
    // lat - latitude
    // lon - longitude
    // exclude - don't get minutely weather
    static func getURLFor(latitude: Double, longitude: Double) -> String {
        return "\(baseURLString)onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
