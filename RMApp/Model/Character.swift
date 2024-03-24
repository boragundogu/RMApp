//
//  Character.swift
//  RMApp
//
//  Created by Bora Gündoğu on 23.03.2024.
//

import Foundation


struct Character: Codable {
    
    let id: Int
    let name: String
    let status: String
    let image: String
    let gender: String
    let species: String
    let origin: Origin
    let location: Location
    let episode: [String]
    let created: String
    
    struct Origin: Codable{
        let name: String
    }
    
    struct Location: Codable{
        let name: String
    }
    
}
