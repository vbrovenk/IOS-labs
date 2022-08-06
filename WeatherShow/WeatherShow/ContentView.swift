//
//  ContentView.swift
//  WeatherShow
//
//  Created by Vadim on 14.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cityVM = CityViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeaderView(cityVM: cityVM).padding()
                // adding info about weather with scroll
                ScrollView(showsIndicators: false) {
                     CityView(cityVM: cityVM)
                }.padding(.top, 10)
            }.padding(.top, 40)
        }.background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
