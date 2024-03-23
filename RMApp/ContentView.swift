//
//  ContentView.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    let locations = ["dünya", "mars", "jupiter","saturn", "neptun", "gunes","andromeda","dunya2","gunes2","saturn3", "mars5"]
    
    @State private var locName: String = ""
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack{
                ForEach(locations, id:\.self) { loc in
                    Button(action: {
                        self.locName = loc
                    }, label: {
                        Text(loc)
                    })
                }
            }
            .padding()
        }
        
        Text(locName)
        
    }
}

#Preview {
    ContentView()
}
