//
//  DailyWeather.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//

import Foundation

// data model for info of every day in a week
struct DailyWeather: Codable, Identifiable {
    var dt: Int
    var temp: Tempretute
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
        case dt
        case temp
        case weather
    }
    
    init() {
        dt = 0
        temp = Tempretute(min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension DailyWeather {
    var id: UUID {
        return UUID()
    }
}
