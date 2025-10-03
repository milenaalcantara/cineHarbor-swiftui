//
//  TrendingView.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//
import SwiftUI

//
//  TrendingView.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//
import SwiftUI
import Mixpanel

struct TrendingView: View {
    @EnvironmentObject var viewModel: TrendingViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.items) { item in
                        VStack {
                            NavigationLink {
                                DetailView(item: item)
                                    .environmentObject(viewModel)
                                    .onAppear {
                                        Mixpanel.mainInstance().track(event: "DetailView")
                                    }
                            } label: {
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")")) { image in
                                        image.resizable()
                                             .scaledToFill()
                                             .frame(height: 200)
                                             .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            
                            HStack {
                                Text(item.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                    .foregroundColor(.primary)
                                
                                Button {
                                    viewModel.toggleFavorite(item)
                                    
                                    // Envio do evento, com parâmetros
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
                }
                .padding()
            }
            .navigationTitle("Trending")
            .task {
                await viewModel.fetchTrending()
            }
        }
    }
}
