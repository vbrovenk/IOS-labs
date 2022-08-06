//
//  CityViewModel.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//

import SwiftUI
import CoreLocation

// CityViewModel subscribes to protocol ObservableObject and
// in this way SwiftUI can observe after changes
final class CityViewModel: ObservableObject {
    // property wrapper Published allows redraw a view whenever changes occur
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "Kyiv" {
        // observer - after changing of value: city
        didSet {
            // performed request for getting a weather
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    // formatter for getting day of week
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        
    }
    // ---------  Describing of computed properties ----------
    
    // date returns formatted date, which was given from a request to API
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        // check if we got WeatherDetail from request
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        
        return "sun.max.fill"
    }
    
    var temperature: String {
        return getTemperatureFor(temp: weather.current.temp)
    }
    
    // description of weather: Clear, Cloudy, Rainy etc.
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        
        return ""
    }
    
    var windSpeed: String {
        // converting from miles/hour to meters/sesond
        let meters_in_seconds = weather.current.wind_speed * 0.44704
        return String(format: "%0.1f", meters_in_seconds)
    }

    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }

    var rainChances: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    func getTimeFor(timeStamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    func getTemperatureFor(temp: Double) -> String {
        // convert from Fahrenheit to Celsius
        let celsius = (temp - 32) * 5 / 9
        return String(format: "%0.1f", celsius)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    // getting coordinates from a given city
    private func getLocation() {
        // transform city name to geografical coordinates
        CLGeocoder().geocodeAddressString(city) { placeMarks, error in
            if let places = placeMarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    // getting data about the weather for coordinates
    private func getWeather(coord: CLLocationCoordinate2D?) {
        // if there are coord, then we do a request of weather
        if let coord = coord {
            let urlString = API.getURLFor(latitude: coord.latitude, longitude: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        // else we do a request by default coords
        } else {
            let urlString = API.getURLFor(latitude: 50.5139049, longitude: 30.1731287)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    // call http request and return a result
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // allows to choose an animation for the weather: format - 00(n - night | d - day)
    // which depends from an answer in JSON structure
    // animations are stored in directory LottieAnimation
    static func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatteredClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightsShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayMist"
        case "50n":
            return "nightMist"
        default:
            return "dayClearSky"
        }
    }

    // allows to choose icon for the hourly and daily weather format - 00(n - night | d - day)
    // SF Symbols are used for icons
    static func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill") // ясное небо, день
        case "01n":
            return Image(systemName: "moon.fill") // ясное небо, ночь
        case "02d":
            return Image(systemName: "cloud.sun.fill") // малооблачный день
        case "02n":
            return Image(systemName: "cloud.moon.fill") //малооблачная ночь
        case "03d":
            return Image(systemName: "cloud.fill") // рассеянные облака день
        case "03n":
            return Image(systemName: "cloud.fill") //рассеянные облака ночь
        case "04d":
            return Image(systemName: "cloud.fill") // рассеянные облака день
        case "04n":
            return Image(systemName: "cloud.fill") // рассеянные облака ночь
        case "09d":
            return Image(systemName: "cloud.drizzle.fill") // мелкий дождь день
        case "09n":
            return Image(systemName: "cloud.drizzle.fill") // мелкий дождь ночь
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill") // ливень день
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill") //ливень ночь
        case "11d":
            return Image(systemName: "cloud.bolt.fill") //гроза day
        case "11n":
            return Image(systemName: "cloud.bolt.fill") //гроза night
        case "13d":
            return Image(systemName: "cloud.snow.fill") // снег день
        case "13n":
            return Image(systemName: "cloud.snow.fill") // снег ночь
        case "50d":
            return Image(systemName: "cloud.fog.fill") // туман день
        case "50n":
            return Image(systemName: "cloud.fog.fill") // туман ночь
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}
