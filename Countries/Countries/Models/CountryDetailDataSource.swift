//
//  CountryDetailDataSource.swift
//  Countries
//
//  Created by Baha Orhan on 9.07.2022.
//

import Foundation

class CountryDetailDataSource {
    private var countryDetailList = CountryDetail(capital: "", code: "", callingCode: "", currencyCodes: [""], flagImageUri: "", name: "nn", numRegions: 0, wikiDataId: "")
    var delegate: CountryDetailDataSourceDelegate?
    
    init() {
        
    }
    
    func getNumberOfCountryDetails() -> Int {
        let array: [CountryDetail] = [countryDetailList]
        return array.count
    }
    
    func getURL() -> String {
        let array: [CountryDetail] = [countryDetailList]
        return array[0].flagImageUri
    }
    
    func getDetailForIndex(index: Int) -> CountryDetail {
        let array: [CountryDetail] = [countryDetailList]
        let realIndex = index % array.count
        return array[realIndex]
    }
    
    func loadCountryDetails(x: String) {
        let urlSession = URLSession.shared
        if let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(x)/?rapidapi-key=0888273872msh98678998017b2b7p12e4e2jsnfec4c20ff3c3") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let countryDetailArrayFromNetwork = try decoder.decode(DataCountryDetail.self, from: data)
                        let countryDetailData = countryDetailArrayFromNetwork.data
                        self.countryDetailList = countryDetailData
                        print(countryDetailData)
                        DispatchQueue.main.async {
                            self.delegate?.countryDetailListLoaded()
                        }
                    } catch {
                        print("error on decode: \(error.localizedDescription)")
                        print(String(describing: error))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
