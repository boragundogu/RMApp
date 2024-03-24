//
//  SplashView.swift
//  RMApp
//
//  Created by Bora Gündoğu on 24.03.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isSplashActive = false
    
    var body: some View {
        ZStack {
            if self.isSplashActive {
                LocationView()
            } else {
                Color("splashbg").ignoresSafeArea()
                VStack{
                    Image("rmlogo")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isSplashActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
