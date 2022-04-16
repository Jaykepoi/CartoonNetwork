//
//  apiCartoon.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 16.04.2022.
//

import Foundation

struct apiCartoon: Codable {
    let info: Info
    let results: [Result]
}

struct Info: Codable {
    let next: String?
}

struct Result: Codable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let image: String
}
