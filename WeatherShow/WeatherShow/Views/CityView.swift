//
//  CityView.swift
//  WeatherShow
//
//  Created by Vadim on 14.04.2022.
//

import SwiftUI
// main View which combines parts of view
struct CityView: View {
    @ObservedObject var cityVM: CityViewModel
    
    var body: some View {
        VStack {
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 0)
            TodayWeatherView(cityVM: cityVM)
                .padding()
            HourlyWeatherView(cityVM: cityVM)
                .padding()
            DailyWeatherView(cityVM: cityVM)
            
        }.padding(.bottom, 30)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
