//
//  LocationView.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import SwiftUI

struct LocationView: View {
    
    @StateObject var viewModel = LocationVM()
    @StateObject var characterVM = CharacterVM()
    @State private var selectedLocation: Location.Results?
    @State private var characters : [String] = []
    @State private var isFirstFetchDone = false
    @State private var charUrl: String = ""
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack{
                ForEach(viewModel.locations, id:\.id) { location in
                    Button(action: {
                        selectedLocation = location
                        characters = location.residents
                        print(location.name)
                    }, label: {
                        Text(location.name)
                            .foregroundStyle(.black)
                            .padding()
                            .background {
                                Rectangle()
                                    .foregroundStyle(selectedLocation == location ? .gray.opacity(0.5) : .gray)
                                    .clipShape(.buttonBorder)
                            }
                    })
                    .padding(5)
                }
            }
        }
        .onAppear {
            viewModel.fetchLocations { error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let firstLocation = viewModel.locations.first {
                    DispatchQueue.main.async {
                        selectedLocation = firstLocation
                        print(firstLocation.name)
                    }
                }
            }
        }
        .onChange(of: viewModel.locations, { oldValue, newValue in
            if let firstLocation = viewModel.locations.first {
                selectedLocation = firstLocation
            }
            if let residents = selectedLocation?.residents {
                characters = residents
            }
        })
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(characters, id:\.self) { chars in
                    CharacterView(charUrl: chars)
                }
            }
        }
        .padding()
    }
    
    func fetchCharacters(){
        for url in characters {
            characterVM.fetchCharacter(url: url) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    LocationView()
}
