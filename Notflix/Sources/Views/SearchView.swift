//
//  SearchView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 10) {
                    SearchBar(text: $searchViewModel.searchText)
                    if searchViewModel.state == .loading {
                        loadingView
                    } else {
                        if !searchViewModel.items.isEmpty {
                            ScrollView(.vertical, showsIndicators: true) {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(0..<searchViewModel.items.count, id: \.self) { index in
                                        HStack(alignment: .center, spacing: 10) {
                                            ForEach(self.searchViewModel.items[index], id: \.id) { item in
                                                self.cellFor(item)
                                            }
                                        }.frame(maxWidth: .infinity)
                                    }
                                }
                            }.gesture(DragGesture().onChanged { _ in
                                UIApplication.shared.endEditing(true)
                            })
                        } else {
                           EmptyView()
                        }
                    }
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    var loadingView: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<10, id: \.self) { _ in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(0..<3, id: \.self) { _ in
                            self.loadingCell()
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }.gesture(DragGesture().onChanged { _ in
            UIApplication.shared.endEditing(true)
        })
    }

    func loadingCell() -> some View {
        return VStack(alignment: .leading) {
            ShimmerView()
            .frame(width: 100, height: 180)
            .cornerRadius(8.0)
        }
    }

    func cellFor(_ item: SearchItemViewModel) -> some View {
        return Group {
            if item.type == SearchItemViewModel.SearchItemType.tvShow {
                tvShowCellFor(item)
            } else {
                movieCellFor(item)
            }
        }
    }

    func tvShowCellFor(_ item: SearchItemViewModel) -> some View {
        return NavigationLink(destination: TVShowDetails(tvShowId: item.sourceId)) { cellUiFor(item) }
    }

    func movieCellFor(_ item: SearchItemViewModel) -> some View {
         return NavigationLink(destination: MovieDetails(movieId: item.sourceId)) { cellUiFor(item) }
    }

    func cellUiFor(_ item: SearchItemViewModel) -> some View {
        return VStack(alignment: .leading) {
            Group {
                if item.posterUrl != nil {
                    AsyncImage(url: item.posterUrl!,
                               configuration: {AnyView($0.resizable())},
                               defaultView: {
                                AnyView(
                                    Text(item.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                )
                        }).clipped()
                } else {
                    Text(item.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 100, height: 160)
            .background(Color.darkGray)
            .cornerRadius(8.0)
            Text(item.title)
                .font(.system(size: 12, weight: .bold))
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(width: 100)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
