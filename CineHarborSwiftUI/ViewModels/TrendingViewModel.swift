//
//  TrendingViewModel.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//

import SwiftUI

@MainActor
class TrendingViewModel: ObservableObject {
    @Published var items: [TrendingItem] = []
    @Published var favorites: [TrendingItem] = []
    
    func toggleFavorite(_ item: TrendingItem) {
        if favorites.contains(where: { $0.id == item.id }) {
            favorites.removeAll { $0.id == item.id }
        } else {
            favorites.append(item)
        }
    }
    
    func isFavorite(_ item: TrendingItem) -> Bool {
        favorites.contains { $0.id == item.id }
    }
    
    func fetchTrending() async {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=7cd33f57ce1734a36e86edb23ecef15f") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(TrendingResponse.self, from: data)
            self.items = response.results
        } catch {
            print("Erro ao carregar trending: \(error)")
        }
    }
}
