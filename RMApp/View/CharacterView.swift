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
    
    var body: some View {
        VStack{
            if let character = characterVM.character {
                HStack{
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .center)
                            .padding()
                    }
                    Text(character.name)
                        .frame(width: 100, height: 100, alignment: .center)
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

#Preview {
    CharacterView(charUrl: "https://rickandmortyapi.com/api/character/38")
}
