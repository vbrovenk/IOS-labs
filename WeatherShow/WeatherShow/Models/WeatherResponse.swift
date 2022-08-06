//
//  WeatherResponse.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//

import Foundation

// data structure for getting response from API
struct WeatherResponse: Codable {
    // current weather
    var current: Weather
    // hourly weather
    var hourly: [Weather]
    // the weather for week
    var daily: [DailyWeather]
    
    // creating empty objects before making of request to API
    // after API request this values will be changed
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
}
