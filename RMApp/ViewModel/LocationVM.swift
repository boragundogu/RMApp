//
//  LocationVM.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import Foundation
import Alamofire

class LocationVM: ObservableObject {
    
    @Published var locations: [Location.Results] = []
    
    func fetchLocations(completion: @escaping (Error?) -> Void){
        AF.request("https://rickandmortyapi.com/api/location?page=1")
            .validate()
            .responseDecodable(of: Location.self) { response in
                switch response.result {
                case .success(let data):
                    self.locations = data.results
                case .failure(let error):
                    completion(error)
                }
            }
    }

    
}
