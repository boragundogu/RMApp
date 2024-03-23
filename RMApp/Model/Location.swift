//
//  Location.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import Foundation

struct Location: Codable {
    
    let results: [Results]
    
    struct Results: Codable,Equatable {
        let id: Int
        let name: String
        let residents: [String]
    }
    
}
