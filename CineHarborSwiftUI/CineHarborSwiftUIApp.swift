//
//  CineHarborSwiftUIApp.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//

import SwiftUI
import Mixpanel

@main
struct CineHarborSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
    
    init() {
        Mixpanel.initialize(
            token: "b9a6a4d047b3c10398a5dc2939141a5e",
            trackAutomaticEvents: true
        )
    }
}
