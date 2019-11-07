//
//  ContentView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State public var selectedTab: Int = 1

    init() {
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            TabView(selection: $selectedTab) {
                ZStack {
                    Color(.black).edgesIgnoringSafeArea(.all)
                    Text("TV Shows")
                }
                    .tabItem {
                        Text("TV Shows")
                }.tag(0)
                ZStack {
                    Color(.black).edgesIgnoringSafeArea(.all)
                    MoviesView()
                }
                    .tabItem {
                        Text("Movies")
                }.tag(1)
            }
            .accentColor(.red)
            .edgesIgnoringSafeArea(.top)
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
