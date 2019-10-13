//
//  ContentView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieListViewModel = MovieListViewModel()

    var body: some View {
        NavigationView{
            List(self.movieListViewModel.popularMovies) { item in
                if self.movieListViewModel.isLoading { Text("Loading...") } else {
                    Text(item.title).onAppear {
                                      let currIndex = self.movieListViewModel.popularMovies.firstIndex { movie -> Bool in
                                          movie.title == item.title
                                      }
                                      self.getNextPageIfNecessary(encounteredIndex: currIndex ?? -1 )
                                  }
                }
              
            }.navigationBarTitle(Text("Popular movies"))
        }
    }
    
    private func getNextPageIfNecessary(encounteredIndex: Int) {
        print("Encountered : \(encounteredIndex)")
        print("Count : \(self.movieListViewModel.popularMovies.count - 1)")
        print(self.movieListViewModel.page)
        guard encounteredIndex == self.movieListViewModel.popularMovies.count - 10 else { return }
        self.movieListViewModel.nextPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
