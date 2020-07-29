//
//  SearchBar.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color.lightGray)

                TextField("Search", text: $text)
                    .foregroundColor(Color.lightGray)

                Group {
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(Color.lightGray)

                        })
                    } else {
                        EmptyView()
                    }
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(Color.lightGray)
            .background(Color.darkGray)
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"))
    }
}
