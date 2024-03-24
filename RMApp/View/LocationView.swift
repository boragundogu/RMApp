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
            NavigationStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack{
                            ForEach(viewModel.locations, id:\.id) { location in
                                Button(action: {
                                    selectedLocation = location
                                    characters = location.residents
                                }, label: {
                                    Text(location.name)
                                        .foregroundStyle(selectedLocation == location ? .white : .black)
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
                    .background(Color("bgcolor").ignoresSafeArea())
                    .padding(.bottom, 250)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20){
                            ForEach(characters, id:\.self) { chars in
                                CharacterView(charUrl: chars)
                            }
                            
                        }
                    }
                    .background(Color("bgcolor").ignoresSafeArea())
                    .padding(.top, -270)
            }
            .onAppear {
                viewModel.fetchLocations { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let firstLocation = viewModel.locations.first {
                        DispatchQueue.main.async {
                            selectedLocation = firstLocation
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
