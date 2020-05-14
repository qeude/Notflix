//
//  ShimmerView.swift
//  Notflix
//
//  Created by Quentin Eude on 14/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct ShimmerView: View {

    @State private var opacity: Double = 0.25

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.darkGray)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = 1
                }
        }
        
    }
}

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ShimmerView()
                    .frame(width: 100, height: 100)

                ShimmerView()
                    .frame(height: 20)

                ShimmerView()
                    .frame(height: 20)

                ShimmerView()
                    .frame(height: 100)

                ShimmerView()
                    .frame(height: 50)

                ShimmerView()
                    .frame(height: 20)

                ShimmerView()
                    .frame(height: 100)

                ShimmerView()
                    .frame(height: 50)

                ShimmerView()
                    .frame(height: 20)
            }
            .padding()

        }
    }
}
