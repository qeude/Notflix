//
//  ContentView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State public var selectedTab: Int = 0

    init() {
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ZStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text(L10n.Tab.home)
            }.tag(0)
            ZStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text(L10n.Tab.search)
            }.tag(1)
        }
        .accentColor(.red)
        .font(.headline)
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
