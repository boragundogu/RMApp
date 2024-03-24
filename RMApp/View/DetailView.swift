//
//  DetailView.swift
//  RMApp
//
//  Created by Bora Gündoğu on 24.03.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var characterVM = CharacterVM()
    let characterUrl: String
    
    var body: some View {
        ZStack {
            Color("bgcolor").ignoresSafeArea()
            VStack{
                if let character = characterVM.character {
                    Text(character.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .padding(.top, 30)
                    Spacer()
                    AsyncImage(url: URL(string: character.image)) { image in
                        switch image {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 275, height: 275, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            Text("Failed to load image")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.bottom, 60)
                    
                    let episodeArray = character.episode.map{ episodeUrl in
                        if let episodeID = URL(string: episodeUrl)?.lastPathComponent {
                            return episodeID
                        } else {
                            return ""
                        }
                    }.joined(separator: "," + " ")
                    
                    let data : [String:String] = [
                        
                        "Status:":"\(character.status)",
                        "Specy:":"\(character.species)",
                        "Gender:":"\(character.gender)",
                        "Origin:":"\(character.origin.name)",
                        "Location:":"\(character.location.name)",
                        "Episodes:":"\(episodeArray)"
                    ]
                    
                    VStack(alignment: .center, spacing: 10){
                        ForEach(data.sorted(by: { $0.key > $1.key}), id:\.key) { key, value in
                            HStack{
                                Spacer()
                                Text(key)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .frame(width: 100, height: 30, alignment: .center)
                                Spacer()
                                Text(value)
                                    .foregroundStyle(.white)
                                    .frame(width: 200, height: 30, alignment: .center)
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
            }
            .onAppear{
                characterVM.fetchCharacter(url: characterUrl) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}


#Preview {
    DetailView(characterUrl: "https://rickandmortyapi.com/api/character/38")
}
