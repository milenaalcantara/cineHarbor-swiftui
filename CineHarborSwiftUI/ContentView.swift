//
//  ContentView.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//

import SwiftUI
import Mixpanel

struct ContentView: View {
    @StateObject private var trendingVM = TrendingViewModel()
        
    var body: some View {
        TabView {
            TrendingView()
                .environmentObject(trendingVM)
                .tabItem {
                    Label("Trending", systemImage: "flame.fill")
                }
                .onAppear {
                    Mixpanel.mainInstance().track(event: "TrendingView")
                }
            
            FavoritesView()
                .environmentObject(trendingVM)
                .tabItem {
                    Label("Favoritos", systemImage: "heart.fill")
                }
                .onAppear {
                    // Envio do evento para o Mixpanel
                    Mixpanel.mainInstance().track(event: "FavoritesView")
                }
        }
    }
}

#Preview {
    ContentView()
}
