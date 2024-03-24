//
//  CharacterView.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import SwiftUI

struct CharacterView: View {
    
    @StateObject var characterVM = CharacterVM()
    let charUrl: String
    @State private var isDetailActive = false
    
    var body: some View {
        Button(action: {
            isDetailActive.toggle()
        }, label: {
            NavigationStack {
                ZStack {
                    Color("bgcolor").ignoresSafeArea()
                    VStack{
                        if let character = characterVM.character {
                            HStack{
                                AsyncImage(url: URL(string: character.image)) { image in
                                    switch image {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150, alignment: .center)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        Text("Failed to load image")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                Text(character.name)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 10)
                                    .frame(width: 200, height: 150, alignment: .center)
                                    .font(.system(size: 22, weight: .bold, design: .default))
                            }
                            .padding(.trailing, 27)
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 385, height: 150, alignment: .center)
                                    .foregroundStyle(character.gender == "Male" ? .blue.opacity(0.7) : character.gender == "Female" ? .pink.opacity(0.7) : .gray.opacity(0.7))
                            }
                        }
                    }
                    .onAppear{
                        characterVM.fetchCharacter(url: charUrl) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            .navigationDestination(
                isPresented: $isDetailActive){
                    DetailView(characterUrl: charUrl)
                }
        }
               
        )
    }
}

#Preview {
    CharacterView(charUrl: "https://rickandmortyapi.com/api/character/38")
}
