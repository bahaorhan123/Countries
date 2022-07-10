//
//  CountryDetail.swift
//  Countries
//
//  Created by Baha Orhan on 9.07.2022.
//

import Foundation

struct DataCountryDetail: Decodable {
    let data: CountryDetail
}

struct CountryDetail: Decodable {
    let capital: String
    let code: String
    let callingCode: String
    let currencyCodes: [String]
    let flagImageUri: String
    let name: String
    let numRegions: Int
    let wikiDataId: String
}

/*
 {
     "data": {
         "capital": "Accra",
         "code": "GH",
         "callingCode": "+233",
         "currencyCodes": [
             "GHS"
         ],
         "flagImageUri": "http://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20Ghana.svg",
         "name": "Ghana",
         "numRegions": 10,
         "wikiDataId": "Q117"
     }
 }
 */
