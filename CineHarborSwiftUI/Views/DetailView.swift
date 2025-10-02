//
//  DetailView.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//

import SwiftUI
import Mixpanel

struct DetailView: View {
    let item: TrendingItem
    @EnvironmentObject var viewModel: TrendingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")")) { image in
                    image.resizable()
                         .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text("⭐️ \(item.voteAverage, specifier: "%.1f")")
                    .foregroundColor(.green)
                
                Text(item.overview)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.toggleFavorite(item)
                let dict = [
                    "streamTitle": item.title,
                    "isFavorite": "\(viewModel.isFavorite(item))"
                ]
                
                Mixpanel.mainInstance().track(event: "Tap on favorite", properties: dict)
            } label: {
                Image(systemName: viewModel.isFavorite(item) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
    }
}
