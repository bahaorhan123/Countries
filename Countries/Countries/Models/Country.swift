//
//  CountryCode.swift
//  Countries
//
//  Created by Baha Orhan on 7.07.2022.
//

import Foundation


struct savedCountry {
    static var name: [String] = []
}

struct Others: Decodable {
    let data: [Country]
}

struct Country: Decodable {
    let code: String
    let name: String
    let wikiDataId: String
}



