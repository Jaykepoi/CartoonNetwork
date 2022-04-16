//
//  apiCharacter.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 16.04.2022.
//

import Foundation

struct apiCharacter: Codable {
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
}

struct Location: Codable {
    let name: String
    let url: String
}
