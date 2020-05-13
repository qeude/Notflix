//
//  HomeView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

enum SelectedType {
    case tvShows
    case movies
}

struct HomeView: View {
    @State public var selectedType: SelectedType = .tvShows

    var body: some View {
        NavigationView {
            ZStack {
                Color(.black).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        header
                        self.containedView()
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    var header: some View {
        HStack {
            Button(L10n.Home.Tab.tvshows) {
                self.selectedType = .tvShows
            }
            .font(.system(size: 18, weight: .bold))
            .accentColor(self.selectedType == .tvShows ? .red : .white)
            .padding()
            Button(L10n.Home.Tab.movies) {
                self.selectedType = .movies
            }
                .font(.system(size: 18, weight: .bold))

            .accentColor(self.selectedType == .movies ? .red : .white)
            .padding()
        }.padding(.bottom, 40)
    }

    func containedView() -> AnyView {
        switch selectedType {
        case .tvShows: return AnyView(TVShowsView())
        case .movies: return AnyView(MoviesView())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
