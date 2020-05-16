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
//    @State private var searchText = "" {
//        didSet {
//            if searchText != "" {
//                self.searchViewModel.performSearch(for: self.searchText)
//            }
//        }
//    }

    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                SearchBar(text: $searchViewModel.searchText)
                List(searchViewModel.items, id: \.id) {
                    Text("\($0.title)")
                }
            }
            Text(L10n.Tab.search)
                .foregroundColor(.white)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
