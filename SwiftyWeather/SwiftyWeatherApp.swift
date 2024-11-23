//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by Aimee Hong on 11/18/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
        }
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
