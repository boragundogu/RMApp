//
//  CharacterVM.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import Foundation
import Alamofire

class CharacterVM: ObservableObject {
    
    @Published var character: Character?
    
    func fetchCharacter(url: String, completion: @escaping (Error?) -> Void) {
            AF.request(url)
                .validate()
                .responseDecodable(of: Character.self) { response in
                    switch response.result {
                    case .success(let data):
                        self.character = data
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                    }
                }
    }
    
    
}
