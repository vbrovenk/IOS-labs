//
//  MenuHeaderView.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//

import SwiftUI

struct MenuHeaderView: View {
    // @ObservedObject for observing of created object
    @ObservedObject var cityVM: CityViewModel
    
    @State private var searchCity = "Kyiv"
    
    var body: some View {
        HStack {
            TextField("", text: $searchCity)
                .padding(.leading, 20)
            
            Button {
                cityVM.city = searchCity
            } label: {
                // displaying icon on top of a button
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3)
                    
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        // setting properties for search item
        .foregroundColor(.white)
        .padding()
        .background(ZStack (alignment: .leading) {
            Image (systemName: "magnifyingglass")
                .foregroundColor(.purple)
                .padding(.leading, 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.purple.opacity(0.5 ))
        })
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
