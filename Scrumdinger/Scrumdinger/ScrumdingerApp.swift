//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Vadim on 22.03.2024.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
